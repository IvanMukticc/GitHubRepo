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
    let htmlUrl: String
    let owner: Owner

    static let mock = Repository(
        id: 1,
        name: "Laravel",
        forks: 20222,
        openIssues: 1,
        watchers: 18,
        stargazersCount: 22222,
        description: "Coding in php",
        createdAt: Date.now,
        updatedAt: Date.now,
        language: "PHP",
        htmlUrl: "",
        owner: Owner(
            id: 2,
            login: "Jhonny",
            avatarUrl: "O",
            htmlUrl: "https://api.github.com/users/octocat",
            url: "https://api.github.com/users/dtrupenn",
            name: "Jhonny",
            createdAt: Date.now,
            followers: 222,
            following: 888,
            publicRepos: 25,
            email: "example@propeller.hr",
            location: "Čakovec",
            bio: "n/a",
            reposUrl: "https://api.github.com/users/dtrupenn/repos"
        )
    )
}

struct Owner: Codable {
    let id: Int
    let login: String
    let avatarUrl: String
    let htmlUrl: String
    let url: String
    let name: String?
    let createdAt: Date?
    let followers: Int?
    let following: Int?
    let publicRepos: Int?
    let email: String?
    let location: String?
    let bio: String?
    let reposUrl: String?
    static let mock = Owner(
        id: 0,
        login: "John Doe",
        avatarUrl: "O",
        htmlUrl: "https://api.github.com/users/octocat",
        url: "https://api.github.com/users/dtrupenn",
        name: "Jhonny",
        createdAt: Date.now,
        followers: 222,
        following: 888,
        publicRepos: 25,
        email: "example@propeller.hr",
        location: "Čakovec",
        bio: "n/a",
        reposUrl: "https://api.github.com/users/dtrupenn/repos"
    )
}
