import SwiftUI

struct ContentView: View {
    let apiManager = ApiManager()
    @State
    var repositories = [Repository]()
    @State
    private var searchTerm: String = "php"

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(repositories) { repository in
                        Text(repository.name ?? "Pero")
                    }
                }
            }
            .task {
                do {
                    repositories = try await apiManager
                        .getRepositories(for: searchTerm)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
