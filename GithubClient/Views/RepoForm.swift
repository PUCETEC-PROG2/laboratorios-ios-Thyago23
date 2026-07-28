//
//  RepoForm.swift
//  GithubClient
//
//

import SwiftUI

struct RepoForm: View {
    @StateObject private var viewController = RepoFormViewController()

    var body: some View {
        NavigationStack {
            RepoFormBody(viewController: viewController)
                .navigationTitle("Nuevo Repositorio")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct RepoEditForm: View {
    let repo: Repo
    let onSave: () -> Void
    @StateObject private var viewController: RepoFormViewController
    @Environment(\.dismiss) private var dismiss

    init(repo: Repo, onSave: @escaping () -> Void) {
        self.repo = repo
        self.onSave = onSave
        _viewController = StateObject(wrappedValue: RepoFormViewController(editingRepo: repo))
    }

    var body: some View {
        NavigationStack {
            RepoFormBody(viewController: viewController)
                .navigationTitle("Editar Repositorio")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cerrar") { dismiss() }
                    }
                }
                .onChange(of: viewController.successMsg) { _, msg in
                    if msg != nil {
                        onSave()
                        dismiss()
                    }
                }
        }
    }
}

private struct RepoFormBody: View {
    @ObservedObject var viewController: RepoFormViewController

    var body: some View {
        Form {
            Section("Nombre") {
                TextField(
                    "",
                    text: $viewController.repoName,
                    prompt: Text("Nombre del repositorio")
                )
            }

            Section("Descripción") {
                TextEditor(text: $viewController.repoDescription)
                    .frame(minHeight: 120)
            }

            Section {
                if viewController.isLoading {
                    HStack {
                        Spacer()
                        ProgressView(viewController.isEditing ? "Actualizando..." : "Guardando...")
                        Spacer()
                    }
                } else {
                    HStack {
                        Button(action: {
                            viewController.repoName = ""
                            viewController.repoDescription = ""
                        }) {
                            Label("Cancelar", systemImage: "xmark.circle")
                                .padding(.all, 4)
                                .foregroundStyle(Color.red)
                        }
                        .buttonStyle(.bordered)

                        Spacer()

                        Button(action: {
                            Task {
                                await viewController.createRepo()
                            }
                        }) {
                            Label(
                                viewController.isEditing ? "Actualizar" : "Guardar",
                                systemImage: "square.and.arrow.down"
                            )
                            .padding(.all, 4)
                        }
                        .buttonStyle(.borderedProminent)
                        .disabled(viewController.repoName.isEmpty)
                    }
                }
            }
        }
        .alert("Error", isPresented: .constant(viewController.errorMsg != nil)) {
            Button("OK") { viewController.errorMsg = nil }
        } message: {
            Text(viewController.errorMsg ?? "")
        }
        .alert("Éxito", isPresented: .constant(viewController.successMsg != nil)) {
            Button("OK") { viewController.successMsg = nil }
        } message: {
            Text(viewController.successMsg ?? "")
        }
    }
}

#Preview {
    RepoForm()
}
