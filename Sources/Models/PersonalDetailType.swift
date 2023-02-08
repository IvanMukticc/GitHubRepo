import Foundation
import SwiftUI

enum Personal {
    var value: String {
        switch self {
        case let .name(name):
            return name
        case let .email(email):
            return email
        case let .location(location):
            return location
        }
    }

    var text: String {
        switch self {
        case .name:
            return "Name".localized
        case .email:
            return "Email".localized
        case .location:
            return "Location".localized
        }
    }

    case name(name: String), email(email: String), location(location: String)
}
