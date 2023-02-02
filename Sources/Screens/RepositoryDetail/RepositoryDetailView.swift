import SwiftUI

struct RepositoryDetailView: View {
    @StateObject
    var viewModel: ViewModel

    var body: some View {
        Text("\(viewModel.repository.name)")
    }
}

struct RepositoryDetailViewView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryDetailView(viewModel: .init(repository: Repository.mock))
    }
}
