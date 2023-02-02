import Foundation

enum Destination: Identifiable {
    var id: Int {
        switch self {
        case let .details(repository):
            return repository.id
        case let .user(owner):
            return owner.id
        }
    }

    case details(repository: Repository), user(owner: Owner)
}
