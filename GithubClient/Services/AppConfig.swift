//
//  AppConfig.swift
//  GithubClient
//
//  Created by Usuario invitado on 14/7/26.
//
import Foundation

enum AppConfig {
    private static let filname = "config"
    
    private enum Keys {
        static let apiBaseURL = "API_BASE_URL"
        static let apiToken = "API_TOKEN" // 
    }
    
    private static var config: [String: Any]? = {
        guard
            let url = Bundle.main.url(forResource: filname, withExtension: "plist"),
            let data = try? Data(contentsOf: url),
            let plist = try? PropertyListSerialization.propertyList(
                from: data,
                options: [],
                format: nil
            ),
            let dict = plist as? [String: Any]
        else {
            return nil
        }
        return dict
    }()
    
    static var apiBaseURL: String {
        guard let config = config, let value = config[Keys.apiBaseURL] as? String else {
            return "https://api.github.com"
        }
        return value
    }
    
    static var apiToken: String {
        guard let config = config, let value = config[Keys.apiToken] as? String else {
            return ""
        }
        return value
    }
}
