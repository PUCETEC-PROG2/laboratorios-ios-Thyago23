//
//  ContentView.swift
//  GithubClient
//
//  Created by Usuario invitado on 13/1/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            RepoList()
                .tabItem{
                    Label("Repositorios",
                          systemImage: "arrow.trianglehead.branch")
                }
            RepoForm()
                .tabItem{
                    Label("Crear Repositorio",
                            systemImage: "plus")
                }
            Profile()
                .tabItem{
                    Label("Perfil del Usuario",
                            systemImage: "person.crop.circle")
                }
        }
    }
}

#Preview {
    ContentView()
}
