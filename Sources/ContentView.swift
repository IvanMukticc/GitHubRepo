import SwiftUI

struct ContentView: View {
    let apiManager = ApiManager()
    @State
    var repositories = [Repository]()
    @State
    private var searchTerm: String = ""
    @State
    private var isError = false
    @State
    private var message = ""


    var body: some View {
        NavigationView {
            List {
                ForEach(repositories) { repository in
                    Text(repository.name ?? "N/A")
                }
            }
            .searchable(text: $searchTerm, prompt: "Please enter search term")
            .onChange(of: searchTerm, perform: { _ in
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    Task {
                        do {
                            repositories = try await apiManager
                                .getRepositories(for: searchTerm)
                        } catch {
                            message =
                                "Could not find any data on \(searchTerm). Please try something else."
                            isError = true
                        }
                    }
                }
            })
            .alert(isPresented: $isError) {
                Alert(title: Text("Error"), message: Text(message))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
