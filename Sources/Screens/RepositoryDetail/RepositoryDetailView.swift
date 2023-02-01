import SwiftUI

struct RepositoryDetailView: View {
    @StateObject
    var viewModel: RepositoryListView.ViewModel
    var repository: Repository

    var body: some View {
        Text(repository.name)
    }
}

struct RepositoryDetailViewView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryDetailView(
            viewModel: RepositoryListView.ViewModel(),
            repository: Repository.mock
        )
    }
}
