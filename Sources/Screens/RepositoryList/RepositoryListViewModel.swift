import Foundation
import SwiftUI

extension RepositoryListView {
    @MainActor
    class ViewModel: ObservableObject {
        let apiManager = ApiManager()
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
