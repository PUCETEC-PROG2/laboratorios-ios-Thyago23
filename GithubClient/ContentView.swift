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
                .tabItem {
                    Label("Repos", systemImage: "arrow.trianglehead.branch")
                }
            RepoForm()
                .tabItem {
                    Label("Crear Repositorio", systemImage: "plus")
                }
            Profile()
                .tabItem {
                    Label("Perfil", systemImage: "person.crop.circle")
                }
        }
    }
}

#Preview {
    ContentView()
}
