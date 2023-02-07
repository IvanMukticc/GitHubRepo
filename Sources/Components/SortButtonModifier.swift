import Foundation
import SwiftUI

struct SortButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .buttonStyle(BorderedButtonStyle())
            .foregroundColor(.black)
            .cornerRadius(20)
    }
}

extension View {
    func sortButtonModifier() -> some View {
        modifier(SortButtonModifier())
    }
}
