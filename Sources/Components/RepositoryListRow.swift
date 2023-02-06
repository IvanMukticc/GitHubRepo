import SwiftUI

struct RepositoryListRow: View {
    var repository: Repository
    var actionHandler: ((Destination) -> Void)?
    var apiManager = ApiManager()

    var body: some View {
        HStack {
            Button {
                Task {
                    let owner = try await ApiManager.fetch(
                        type: Owner.self,
                        with: ApiManager
                            .getUrlRequest(url: repository.owner.url)
                    )
                    actionHandler?(.user(owner: owner))
                }
            } label: {
                AsyncImage(url: URL(string: repository.owner.avatarUrl))
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .overlay {
                        Circle().stroke(.white, lineWidth: 2)
                            .shadow(radius: 7)
                    }
            }

            Button {
                actionHandler?(.details(repository: repository))
            } label: {
                HStack {
                    VStack(alignment: .leading) {
                        Text(repository.name)
                            .textFontModifier(size: 20, weight: .bold)

                        Text(repository.owner.login)
                            .textFontModifier(size: 15, weight: .semibold)
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        InfoIconView(type: .stars(
                            stars: repository
                                .stargazersCount
                        ))
                        InfoIconView(type: .watchers(
                            watchers: repository
                                .watchers
                        ))
                        InfoIconView(type: .forks(forks: repository.forks))
                    }
                }
                .contentShape(Rectangle())
            }
        }
    }
}

struct RepositoryListRow_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryListRow(
            repository: Repository.mock
        )
    }
}
