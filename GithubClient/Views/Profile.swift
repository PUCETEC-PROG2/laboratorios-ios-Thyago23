//
//  Profile.swift
//  GithubClient
//
//  Created by Usuario invitado on 7/7/26.
//

import SwiftUI

struct Profile: View {
    var body: some View {
        NavigationStack{
            VStack (alignment: .leading){
                Text("Santiago Cedeño")
                    .font(.title)
                    .font(.headline)
                Image(uiImage: .githubLogo)
                    .resizable()
                    .scaledToFit()
                Text("Thyago23")
                    .font(.headline)
                    .padding(.vertical)
                Text("Estuadiante de programación")
                    .font(.caption)
            }
            .padding()
            .navigationTitle("Perfil")
        }
    }
}

#Preview {
    Profile()
}
