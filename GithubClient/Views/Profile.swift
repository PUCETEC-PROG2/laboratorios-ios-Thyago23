//
//  Profile.swift
//  GithubClient
//

import SwiftUI

@MainActor
class ProfileViewController: ObservableObject {
    @Published var user: UserInfo?
    @Published var isLoading: Bool = false
    @Published var errorMsg: String?
    
    private let githubService: GithubService
    
    init(service: GithubService = .shared) {
        self.githubService = service
    }
    
    func loadUser() async {
        isLoading = true
        errorMsg = nil
        do {
            user = try await githubService.getUser()
        } catch {
            errorMsg = error.localizedDescription
        }
        isLoading = false
    }
}

struct Profile: View {
    @StateObject private var controller = ProfileViewController()
    
    var body: some View {
        NavigationStack {
            VStack {
                if controller.isLoading {
                    ProgressView("Cargando perfil...")
                } else if let errorMsg = controller.errorMsg {
                    VStack(spacing: 12) {
                        Image(systemName: "exclamationmark.triangle")
                            .font(.largeTitle)
                            .foregroundStyle(.red)
                        Text(errorMsg)
                            .multilineTextAlignment(.center)
                        Button("Reintentar") {
                            Task {
                                await controller.loadUser()
                            }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding()
                } else if let user = controller.user {
                    VStack(spacing: 20) {
                        AsyncImage(url: URL(string: user.avatarUrl)) { image in
                            image
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                        
                        Text(user.name ?? user.login)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text("@\(user.login)")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        
                        if let bio = user.bio {
                            Text(bio)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                        }
                        Spacer()
                    }
                    .padding()
                }
            }
            .navigationTitle("Perfil del Usuario")
            .navigationBarTitleDisplayMode(.inline)
            .task {
                await controller.loadUser()
            }
        }
    }
}

#Preview {
    Profile()
}

