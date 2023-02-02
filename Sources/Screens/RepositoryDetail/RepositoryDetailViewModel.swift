import Foundation
import SwiftUI

extension RepositoryDetailView {
    class ViewModel: ObservableObject {
        @Published
        var repository: Repository

        init(repository: Repository) {
            self.repository = repository
        }
    }
}
