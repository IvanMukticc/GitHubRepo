import Foundation
import SwiftUI

struct CountsEmojiModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 22, height: 14)
            .fixedSize()
            .padding(.trailing)
    }
}

extension View {
    func countsEmojiModifier() -> some View {
        modifier(CountsEmojiModifier())
    }
}
