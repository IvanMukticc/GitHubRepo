import Foundation
import SwiftUI

class ViewModel: ObservableObject {
    @Published
    var owner: Owner

    init(owner: Owner) {
        self.owner = owner
    }
}
