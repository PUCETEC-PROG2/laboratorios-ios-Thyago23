//
//  RepoListViewController.swift
//  GithubClient
//
//

import Foundation

@MainActor
class RepoListViewController: ObservableObject {
    @Published var repos: [Repo] = []
    @Published var isLoading: Bool = false
    @Published var errorMsg: String?

    private let githubService: GithubService

    init(service: GithubService = .shared) {
        self.githubService = service
    }

    func loadRepositories() async {
        isLoading = true
        errorMsg = nil
        do {
            repos = try await githubService.getRepositories()
        } catch {
            errorMsg = error.localizedDescription
        }
        isLoading = false
    }

    func deleteRepository(repo: Repo) async {
        errorMsg = nil
        do {
            try await githubService.deleteRepository(owner: repo.owner.login, name: repo.name)
            repos.removeAll { $0.id == repo.id }
        } catch {
            errorMsg = error.localizedDescription
        }
    }
}
