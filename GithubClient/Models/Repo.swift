//
//  Repo.swift
//  GithubClient
//
//  Created by Bryan Taco on 14/7/26.
//

import Foundation

struct Repo: Identifiable, Decodable {
    let id: Int
    let name: String
    let description: String?
    let language: String?
    let owner: UserInfo
}

