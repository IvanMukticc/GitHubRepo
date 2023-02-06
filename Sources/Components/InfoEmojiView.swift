import SwiftUI

struct InfoEmojiView: View {
    var type: InfoEmojiType

    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text(type.emoji)
                .countsEmojiModifier()
            Text(type.name)
            Spacer()
            Text(type.value)
        }
    }
}

struct InfoEmojiView_Previews: PreviewProvider {
    static var previews: some View {
        InfoEmojiView(type: .forks(forks: 1))
    }
}
