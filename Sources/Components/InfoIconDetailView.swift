import SwiftUI

struct InfoIconDetailView: View {
    var type: InfoIconType
    var body: some View {
        HStack {
            type.icon
                .fixedSize()
                .frame(width: 35)
                .foregroundColor(type.color)
            Text(type.value)
                .textFontModifier(size: 20)
        }
    }
}

struct InfoIconDetailView_Previews: PreviewProvider {
    static var previews: some View {
        InfoIconDetailView(type: .forks(forks: 1))
    }
}
