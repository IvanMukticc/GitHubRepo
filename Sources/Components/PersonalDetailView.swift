import SwiftUI

struct PersonalDetailView: View {
    var type: Personal

    var body: some View {
        VStack(alignment: .leading) {
            Text(type.text)
                .textFontModifier(size: 18, weight: .semibold)
            Text(type.value)
        }
    }
}

struct PersonalDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalDetailView(type: .name(name: "Joe"))
    }
}
