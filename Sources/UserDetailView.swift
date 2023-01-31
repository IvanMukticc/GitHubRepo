import SwiftUI

struct UserDetailView: View {
    var owner: Owner

    var body: some View {
        Text("User Detail view for user: \(owner.login)")
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailView(owner: Owner(
            id: 0,
            login: "Kurac",
            avatarUrl: "fsdfsdf",
            url: "sdflkjfsd"
        ))
    }
}
