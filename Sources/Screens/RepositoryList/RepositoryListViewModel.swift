import Foundation
import SwiftUI

extension RepositoryListView {
    @MainActor
    class ViewModel: ObservableObject {
        @Published
        var repositories = [Repository]()
        @Published
        var searchTerm: String = ""
        @Published
        var errorAlertPresented = false
        @Published
        var errorMessage = ""
        @Published
        var timeRemaining = 1
        let timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
        @Published
        var shouldTriggerRequest = false
        @Published
        var destination: Destination?

        func fetchData() {
            Task {
                do {
                    repositories = try await ApiManager.shared.fetch(
                        type: Root.self,
                        endpoint: ApiManager.Endpoint
                            .searchRepositories(query: searchTerm)
                    ).items ?? []
                } catch {
                    if !repositories.isEmpty {
                        errorAlertPresented = true
                        errorMessage =
                            "Could not find any data on \(searchTerm). Please try something else."
                    }
                }
            }
        }
    }
}
