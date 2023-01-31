import SwiftUI

struct RepositoryListView: View {
    @StateObject
    var viewModel: ViewModel
    @State
    var destination: Destination?

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.repositories) { repository in
                    RepositoryListRow(repository: repository) { destination in
                        self.destination = destination
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
        .sheet(item: $destination, onDismiss: {
            destination = nil
        }) { destination in
            switch destination {
            case let .details(repository):
                RepositoryDetailView(repository: repository)
            case let .user(owner):
                UserDetailView(owner: owner)
            }
        }
    }
}

struct RepositoryListView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryListView(viewModel: RepositoryListView.ViewModel())
    }
}
