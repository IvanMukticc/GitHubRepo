import SwiftUI

struct UserDetailView: View {
    @StateObject
    var viewModel: RepositoryListView.ViewModel
    var owner: Owner

    var body: some View {
        Text("User Detail view for user: \(owner.login)")
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailView(
            viewModel: RepositoryListView.ViewModel(),
            owner: Owner.mock
        )
    }
}
