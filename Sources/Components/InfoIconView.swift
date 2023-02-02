import SwiftUI

struct InfoIconView: View {
    @State
    var type: InfoIconType

    var body: some View {
        HStack {
            Text(type.value)
                .textFontModifier(size: 15)
            type.icon
                .fixedSize()
                .frame(width: 20)
                .foregroundColor(type.color)
        }
    }
}

struct InfoIconView_Previews: PreviewProvider {
    static var previews: some View {
        InfoIconView(type: .forks(forks: 1))
    }
}
