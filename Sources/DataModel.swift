import Foundation

struct Root: Codable {
    let items: [Repository]?
}

struct Repository: Codable, Identifiable {
    let id: Int
    let name: String?
    let forks: Int?
    let openIssues: Int?
    let watchers: Int?
    let stargazersCount: Int?
    let description: String?
    let createdAt: Date?
    let updatedAt: Date?
    let language: String?
    let owner: Owner?
}

struct Owner: Codable {
    let id: Int
    let login: String?
    let avatarUrl: String?
}
