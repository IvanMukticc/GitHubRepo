import Foundation
import SwiftUI

enum InfoIconType {
    var value: String {
        switch self {
        case let .stars(stars: stars):
            return "\(stars)"
        case let .watchers(watchers: watchers):
            return "\(watchers)"
        case let .forks(forks: forks):
            return "\(forks)"
        }
    }

    var icon: Image {
        switch self {
        case .stars:
            return Image(systemName: "star.fill")
        case .watchers:
            return Image(systemName: "eye.fill")
        case .forks:
            return Image(systemName: "tuningfork")
        }
    }

    var color: Color {
        switch self {
        case .stars:
            return Color.yellow
        case .watchers:
            return Color.blue
        case .forks:
            return Color.black
        }
    }

    case stars(stars: Int), watchers(watchers: Int), forks(forks: Int)
}
