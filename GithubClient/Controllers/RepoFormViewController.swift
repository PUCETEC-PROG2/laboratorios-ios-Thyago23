//
//  RepoFormViewController.swift
//  GithubClient
//
//  Created by Bryan Taco on 7/21/26.
//

import Foundation

@MainActor
class RepoFormViewController: ObservableObject {
    @Published var repoName: String = ""
    @Published var repoDescription: String = ""
    @Published var repo: Repo? = nil
    @Published var isLoading: Bool = false
    @Published var errorMsg: String?
    @Published var successMsg: String?

    private let githubService: GithubService
    private let editingRepo: Repo?

    var isEditing: Bool { editingRepo != nil }

    init(service: GithubService = .shared, editingRepo: Repo? = nil) {
        self.githubService = service
        self.editingRepo = editingRepo
        if let repo = editingRepo {
            self.repoName = repo.name
            self.repoDescription = repo.description ?? ""
        }
    }

    func createRepo() async {
        isLoading = true
        errorMsg = nil
        successMsg = nil
        do {
            if let editing = editingRepo {
                repo = try await githubService.updateRepository(
                    owner: editing.owner.login,
                    repoName: editing.name,
                    newName: repoName,
                    desc: repoDescription
                )
                successMsg = "Repositorio actualizado exitosamente"
            } else {
                repo = try await githubService.createRepository(name: repoName, desc: repoDescription)
                successMsg = "Repositorio creado exitosamente"
                repoName = ""
                repoDescription = ""
            }
        } catch {
            errorMsg = error.localizedDescription
        }
        isLoading = false
    }
}
