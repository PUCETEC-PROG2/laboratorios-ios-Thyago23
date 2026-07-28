//
//  RepoItem.swift
//  GithubClient
//
//

import SwiftUI

struct RepoItem: View {
    let repos: Repo
    var onEdit: (() -> Void)? = nil
    var onDelete: (() -> Void)? = nil

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: repos.owner.avatarUrl)) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                Image(uiImage: .githubLogo)
                    .resizable()
                    .scaledToFit()
            }
            .frame(width: 80, height: 80)
            .padding(.trailing, 8)

            VStack(alignment: .leading) {
                Text(repos.name)
                    .font(.title2)

                if let description = repos.description {
                    Text(description)
                        .font(.caption)
                }

                if let language = repos.language {
                    HStack {
                        Text("Lenguaje")
                            .font(Font.body.bold())
                        Spacer()
                        Text(language)
                            .font(.body)
                    }
                }

                if onEdit != nil || onDelete != nil {
                    HStack {
                        if let onEdit = onEdit {
                            Button(action: onEdit) {
                                Label("Editar", systemImage: "pencil")
                                    .font(.caption)
                            }
                            .buttonStyle(.bordered)
                            .tint(.blue)
                        }

                        Spacer()

                        if let onDelete = onDelete {
                            Button(action: onDelete) {
                                Label("Eliminar", systemImage: "trash")
                                    .font(.caption)
                            }
                            .buttonStyle(.bordered)
                            .tint(.red)
                        }
                    }
                    .padding(.top, 4)
                }
            }
        }
        .padding()
    }
}

#Preview {
    RepoItem(
        repos: Repo(
            id: 1,
            name: "laboratorios-ios",
            description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
            language: "Swift",
            owner: UserInfo(
                login: "Thyago23",
                name: "Santiago Cedeño",
                avatarUrl: "",
                bio: "Esta es una Bio de Prueba para ios"
            )
        ),
        onEdit: { print("Editar") },
        onDelete: { print("Eliminar") }
    )
}
