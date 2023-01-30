import SwiftUI

struct RepositoryListView: View {
    @StateObject
    var viewModel: ViewModel

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.repositories) { repository in
                    Text(repository.name)
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
    }
}

struct RepositoryListView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryListView(viewModel: RepositoryListView.ViewModel())
    }
}
