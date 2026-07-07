//
//  RepoList.swift
//  GithubClient
//
//  Created by Usuario invitado on 7/7/26.
//

import SwiftUI
struct RepoList:View {
    var body: some View {
        NavigationStack {
            VStack {
                Repoitem()
                Repoitem()
                Repoitem()
                Repoitem()
                Repoitem()
            }
            .navigationTitle("Repositorios")
            .navigationBarTitleDisplayMode(
            .inline)
        }
    }
}
#Preview{
        RepoList()
    }
