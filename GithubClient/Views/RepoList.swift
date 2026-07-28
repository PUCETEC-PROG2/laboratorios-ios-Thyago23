//
//  RepoList.swift
//  GithubClient
//

import SwiftUI

struct RepoList: View {
    @StateObject private var controller = RepoListViewController()
    @State private var repoToEdit: Repo? = nil

    var body: some View {
        NavigationStack {
            Group {
                if controller.isLoading {
                    ProgressView("Cargando repositorios...")
                } else if let errorMsg = controller.errorMsg {
                    VStack(spacing: 12) {
                        Image(systemName: "exclamationmark.triangle")
                            .font(.largeTitle)
                            .foregroundStyle(.red)
                        Text(errorMsg)
                            .multilineTextAlignment(.center)
                        Button("Reintentar") {
                            Task {
                                await controller.loadRepositories()
                            }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding()
                } else {
                    List(controller.repos) { repo in
                        RepoItem(
                            repos: repo,
                            onEdit: {
                                repoToEdit = repo
                            },
                            onDelete: {
                                Task {
                                    await controller.deleteRepository(repo: repo)
                                }
                            }
                        )
                    }
                    .listStyle(.plain)
                    .refreshable {
                        await controller.loadRepositories()
                    }
                }
            }
            .navigationTitle("Repositorios")
            .task {
                await controller.loadRepositories()
            }
            .sheet(item: $repoToEdit) { repo in
                RepoEditForm(repo: repo) {
                    Task {
                        await controller.loadRepositories()
                    }
                }
            }
        }
    }
}

#Preview {
    RepoList()
}
