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
                        endpoint: .searchRepositories(query: searchTerm)
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

        func sortList(by sortType: SortBy) {
            switch sortType {
            case .starsAsc:
                repositories.sort {
                    $0.stargazersCount > $1.stargazersCount
                }
            case .starsDes:
                repositories.sort {
                    $0.stargazersCount < $1.stargazersCount
                }
            case .forksAsc:
                repositories.sort {
                    $0.forks > $1.forks
                }
            case .forksDes:
                repositories.sort {
                    $0.forks < $1.forks
                }
            case .updatedAsc:
                repositories.sort {
                    $0.updatedAt ?? Date.now > $1.updatedAt ?? Date.now
                }
            case .updatedDes:
                repositories.sort {
                    $0.updatedAt ?? Date.now < $1.updatedAt ?? Date.now
                }
            }
        }
    }
}
