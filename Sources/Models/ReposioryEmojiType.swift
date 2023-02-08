import Foundation
import SwiftUI

enum ReposioryEmojiType {
    var value: String {
        switch self {
        case let .stars(stars):
            return "\(stars)"
        case let .forks(forks):
            return "\(forks)"
        case let .watchers(watchers):
            return "\(watchers)"
        }
    }

    var emoji: String {
        switch self {
        case .stars:
            return "⭐️"
        case .forks:
            return "⫚"
        case .watchers:
            return "👀"
        }
    }

    var name: String {
        switch self {
        case .stars:
            return "Stars".localized
        case .forks:
            return "Forks".localized
        case .watchers:
            return "Watchers".localized
        }
    }

    case stars(stars: Int), forks(forks: Int), watchers(watchers: Int)
}
