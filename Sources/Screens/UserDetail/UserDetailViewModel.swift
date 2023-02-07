import Foundation
import SwiftUI

extension UserDetailView {
    class ViewModel: ObservableObject {
        @Published
        var owner: Owner
        @Published
        var repositories: [Repository] = []

        init(owner: Owner) {
            self.owner = owner
        }
    }
}
