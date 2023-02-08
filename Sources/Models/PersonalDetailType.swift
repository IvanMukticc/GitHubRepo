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
            return String(localized: "Name")
        case .email:
            return String(localized: "Email")
        case .location:
            return String(localized: "Location")
        }
    }

    case name(name: String), email(email: String), location(location: String)
}
