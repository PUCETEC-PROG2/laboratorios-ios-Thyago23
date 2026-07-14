//
//  Repoitem.swift
//  GithubClient
//
//  Created by Usuario invitado on 7/7/26.
//
import SwiftUI

struct RepoItem: View {
    let repository: Repository
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: repository.owner.avatarUrl)!) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Image("githubLogo")
                    .resizable()
                    .scaledToFill()
            }
            .frame(width: 80, height: 80)
            
            Spacer()
            
            VStack(alignment: .leading) {
                Text(repository.name)
                    .font(.title2)
                
                if let description = repository.description {
                    Text(description)
                        .font(.caption)
                }
                
                if let language = repository.language {
                    HStack {
                        Text("Lenguaje")
                            .font(.caption)
                        Spacer()
                        Text(language)
                            .font(.caption)
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    RepoItem(
        repository: Repository(
            id: 1,
            name: "Santiago Cedeño",
            description: "Estudiante de Desarrollo de software",
            language: "Swift",
            owner: UserInfo(
                login: "SantiagoCedeño",
                name: "Santiago",
                avatarUrl: "https://www.google.com",
                bio: "Esta es una prueba"
            )
        )
    )
}


