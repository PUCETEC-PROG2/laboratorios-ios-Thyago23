//
//  Repoitem.swift
//  GithubClient
//
//  Created by Usuario invitado on 7/7/26.
//

import SwiftUI


struct Repoitem: View{
    var body: some View{
        HStack {
            Image (uiImage: .githubLogo)
                .resizable()
                .frame(width: 120, height: 120)
            Spacer()
            VStack (alignment: .leading){
                Text("Nombre del repositorio")
                    .font(.title2)
                Text("Lorem Inpsun dolor descripcion del repositorio")
                HStack {
                    Text("Lenguaje:")
                        .font(.caption)
                    Spacer()
                    Text("Swift")
                        .font(.caption)
                }
            }
        }
        .padding()
    }
}

#Preview {
    Repoitem()
}
