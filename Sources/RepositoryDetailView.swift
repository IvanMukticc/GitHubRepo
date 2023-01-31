import SwiftUI

struct RepositoryDetailView: View {
    var repository: Repository

    var body: some View {
        Text(repository.name)
    }
}

struct RepositoryDetailViewView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryDetailView(repository: Repository.mock)
    }
}
