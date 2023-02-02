import SwiftUI

struct UserDetailView: View {
    @StateObject
    var viewModel: ViewModel

    var body: some View {
        Text("User Detail view for user: \(viewModel.owner.login)")
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailView(viewModel: ViewModel(owner: Owner.mock))
    }
}
