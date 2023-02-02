import Foundation
import SwiftUI

struct TextModifier: ViewModifier {
    var size: CGFloat
    var weight: Font.Weight

    func body(content: Content) -> some View {
        content
            .font(.system(size: size, weight: weight))
            .multilineTextAlignment(.leading)
    }
}

extension View {
    func textFontModifier(
        size: CGFloat,
        weight: Font.Weight = .regular
    ) -> some View {
        modifier(TextModifier(size: size, weight: weight))
    }
}
