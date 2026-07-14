//
//  GithubService.swift
//  GithubClient
//
//  Created by Usuario invitado on 14/7/26.
//
import Foundation
import Alamofire

class GithubService {
    static let shared = GithubService()
    private let baseUrl = AppConfig.apiBaseURL
    
    private init() {}
    
    private var headers: HTTPHeaders {
        [
            "Authorization": "Bearer \(AppConfig.apiToken)"
        ]
    }
    
    func getRepositories() async throws -> [Repository] {
        return try await AF.request(
            "\(baseUrl)/user/repos",
            method: .get,
            parameters: [
                "sort": "created",
                "direction": "desc",
                "per_page": 100,
                "affiliation": "owner"
            ],
            headers: headers
        )
        .validate(statusCode: 200..<300)
        .serializingDecodable([Repository].self)
        .value
    }
}
