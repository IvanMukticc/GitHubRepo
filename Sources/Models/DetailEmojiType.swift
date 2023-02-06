import Foundation
import SwiftUI

enum DetailEmojiType {
    var value: String {
        switch self {
        case let .followers(followers):
            return "\(followers)"
        case let .following(following):
            return "\(following)"
        case let .publicRepos(publicRepos):
            return "\(publicRepos)"
        }
    }

    var emoji: String {
        switch self {
        case .followers:
            return "👈"
        case .following:
            return "👉"
        case .publicRepos:
            return "☑️"
        }
    }

    var text: String {
        switch self {
        case .followers:
            return "followers"
        case .following:
            return "following"
        case .publicRepos:
            return "publicRepos"
        }
    }

    case followers(followers: Int), following(following: Int),
         publicRepos(publicRepos: Int)
}
