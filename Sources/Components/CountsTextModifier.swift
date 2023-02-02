import Foundation
import SwiftUI

struct CountsTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 22, height: 14)
            .fixedSize()
            .padding(.trailing)
    }
}

extension View {
    func countsTextModifier() -> some View {
        modifier(CountsTextModifier())
    }
}
