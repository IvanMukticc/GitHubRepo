import Foundation

struct Root: Codable {
    let items: [Repository]?
}

struct Repository: Codable, Identifiable {
    let id: Int
    let name: String
    let forks: Int
    let openIssues: Int
    let watchers: Int
    let stargazersCount: Int
    let description: String?
    let createdAt: Date
    let updatedAt: Date?
    let language: String?
    let url: String
    let owner: Owner

    static let mock = Repository(
        id: 1,
        name: "Laravel",
        forks: 20,
        openIssues: 1,
        watchers: 18,
        stargazersCount: 22,
        description: "Coding in php",
        createdAt: Date.now,
        updatedAt: Date.now,
        language: "PHP",
        url: "",
        owner: Owner(
            id: 2,
            login: "Jhonny",
            avatarUrl: "O",
            url: "https://api.github.com/users/octocat"
        )
    )
}

struct Owner: Codable {
    let id: Int
    let login: String
    let avatarUrl: String
    let url: String
}
