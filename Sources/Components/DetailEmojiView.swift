import SwiftUI

struct DetailEmojiView: View {
    let type: DetailEmojiType

    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text(type.emoji)
                .countsEmojiModifier()
            Text(type.text)
            Spacer()
            Text(type.value)
        }
    }
}

struct DetailEmojiView_Previews: PreviewProvider {
    static var previews: some View {
        DetailEmojiView(type: .followers(followers: 2))
    }
}
