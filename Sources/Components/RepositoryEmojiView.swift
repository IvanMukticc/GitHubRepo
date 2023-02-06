import SwiftUI

struct RepositoryEmojiView: View {
    var type: ReposioryEmojiType

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

struct RepositoryEmojiView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryEmojiView(type: .forks(forks: 1))
    }
}
