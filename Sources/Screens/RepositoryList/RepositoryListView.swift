import SwiftUI

struct RepositoryListView: View {
    @StateObject
    var viewModel: ViewModel

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.repositories) { repository in
                    RepositoryListRow(repository: repository) { destination in
                        viewModel.destination = destination
                    }
                    .buttonStyle(.plain)
                }
            }
            .searchable(
                text: $viewModel.searchTerm,
                prompt: "Please enter search term"
            )
            .onReceive(viewModel.timer) { _ in
                if viewModel.timeRemaining > 0 {
                    viewModel.timeRemaining -= 1
                } else {
                    if viewModel.shouldTriggerRequest {
                        viewModel.shouldTriggerRequest = false
                        viewModel.fetchData()
                    }
                }
            }
            .navigationTitle(Text("Repositories"))
            .onChange(of: viewModel.searchTerm, perform: { _ in
                viewModel.shouldTriggerRequest = true
                viewModel.timeRemaining = 1
            })
            .alert(isPresented: $viewModel.errorAlertPresented) {
                Alert(
                    title: Text("Error"),
                    message: Text(viewModel.errorMessage)
                )
            }
        }
        .sheet(item: $viewModel.destination, onDismiss: {
//            viewModel.destination = nil
        }) { destination in
            switch destination {
            case let .details(repository):
                RepositoryDetailView(viewModel: .init(repository: repository)) { destination in
                    viewModel.destination = destination
                }
            case let .user(owner):
                UserDetailView(viewModel: .init(owner: owner))
            }
        }
    }
}

struct RepositoryListView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryListView(viewModel: RepositoryListView.ViewModel())
    }
}
