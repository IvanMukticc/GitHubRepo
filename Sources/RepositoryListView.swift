import SwiftUI

struct RepositoryListView: View {
    let apiManager = ApiManager()
    @State
    var repositories = [Repository]()
    @State
    private var searchTerm: String = ""
    @State
    private var errorAlertPresented = false
    @State
    private var errorMessage = ""
    @State
    private var timeRemaining = 1
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State
    var shouldTriggerRequest = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(repositories) { repository in
                    Text(repository.name)
                }
            }
            .searchable(text: $searchTerm, prompt: "Please enter search term")
            .onReceive(timer) { _ in
                if timeRemaining > 0 {
                    timeRemaining -= 1
                } else {
                    if shouldTriggerRequest {
                        shouldTriggerRequest = false
                        Task {
                            do {
                                repositories = try await apiManager
                                    .getRepositories(for: searchTerm)
                            } catch {
                                errorAlertPresented = true
                                errorMessage =
                                "Could not find any data on \(searchTerm). Please try something else."
                            }
                        }
                    }
                }
            }
            .onChange(of: searchTerm, perform: { _ in
                shouldTriggerRequest = true
                timeRemaining = 1
            })
            .alert(isPresented: $errorAlertPresented) {
                Alert(title: Text("Error"), message: Text(errorMessage))
            }
        }
    }
}

struct RepositoryListView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryListView()
    }
}
