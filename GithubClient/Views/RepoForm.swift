//
//  RepoForm.swift
//  GithubClient
//
//  Created by Usuario invitado on 7/7/26.
//

import SwiftUI

struct RepoForm: View {
    @State private var repoName: String = ""
    @State private var repoDescription: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                TextField("",
                          text: $repoName,
                          prompt: Text("Nombre del Repositorio")
                            .foregroundStyle(.black.opacity(0.5))
                )
                .textFieldStyle(.roundedBorder)
                .padding(.vertical)
                
                TextField("",
                          text: $repoDescription,
                          prompt: Text("Descripcion del repositorio")
                            .foregroundStyle(.black.opacity(0.5))
                )
                .textFieldStyle(.roundedBorder)
                .lineLimit(3...6)
                .padding(.vertical)
                
                Spacer()
                
                HStack{
                    Button(action: {
                        print("Botón presionado")
                    }) {
                        Label("Cancelar", systemImage: "xmark.circle")
                            .padding(.all,4)
                            .foregroundStyle(.red)
                    }
                    .buttonStyle(.bordered)
                    .padding(.horizontal,4)
                    
                    Button(action: {
                        print("Botón presionado")
                    }) {
                        Label("Guardar", systemImage: "square.and.arrow.down")
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding()
                .navigationTitle("Formulario de repositorio")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

#Preview {
    RepoForm()
}
