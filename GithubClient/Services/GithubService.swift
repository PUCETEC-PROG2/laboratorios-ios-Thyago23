//
//  GithubService.swift
//  GithubClient
//
//

import Foundation
import Alamofire

class GithubService {
    static let shared = GithubService()
    private let baseUrl = "https://api.github.com"
    private var token: String {
        let envToken = ProcessInfo.processInfo.environment["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"] ?? ""
        if !envToken.isEmpty {
            return envToken
        }
        return AppConfig.apiToken
    }

    private init() {}

    private var headers: HTTPHeaders {
        [
            "Authorization": "token \(token)",
            "Accept": "application/vnd.github.v3+json"
        ]
    }

    func getUser() async throws -> UserInfo {
        return try await AF.request(
            "\(baseUrl)/user",
            method: .get,
            headers: headers
        )
        .validate(statusCode: 200..<300)
        .serializingDecodable(UserInfo.self)
        .value
    }

    func getRepositories() async throws -> [Repo] {
        return try await AF.request(
            "\(baseUrl)/user/repos",
            method: .get,
            parameters: [
                "sort": "created",
                "direction": "desc",
                "per_page": 100,
                "affiliations": "owner"
            ],
            headers: headers
        )
        .validate(statusCode: 200..<300)
        .serializingDecodable([Repo].self)
        .value
    }

    func createRepository(name: String, desc: String) async throws -> Repo {
        let body: [String: Any] = [
            "name": name,
            "description": desc
        ]
        return try await AF.request(
            "\(baseUrl)/user/repos",
            method: .post,
            parameters: body,
            encoding: JSONEncoding.default,
            headers: headers
        )
        .validate(statusCode: 200..<300)
        .serializingDecodable(Repo.self)
        .value
    }

    func updateRepository(owner: String, repoName: String, newName: String, desc: String) async throws -> Repo {
        let body: [String: Any] = [
            "name": newName,
            "description": desc
        ]
        return try await AF.request(
            "\(baseUrl)/repos/\(owner)/\(repoName)",
            method: .patch,
            parameters: body,
            encoding: JSONEncoding.default,
            headers: headers
        )
        .validate(statusCode: 200..<300)
        .serializingDecodable(Repo.self)
        .value
    }

    func deleteRepository(owner: String, name: String) async throws {
        let response = await AF.request(
            "\(baseUrl)/repos/\(owner)/\(name)",
            method: .delete,
            headers: headers
        )
        .validate(statusCode: 200..<300)
        .serializingData()
        .response

        if let error = response.error {
            throw error
        }
    }
}
