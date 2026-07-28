//
//  Repo.swift
//  GithubClient
//
//

import Foundation

struct Repo: Identifiable, Decodable {
    let id: Int
    let name: String
    let description: String?
    let language: String?
    let owner: UserInfo
}

