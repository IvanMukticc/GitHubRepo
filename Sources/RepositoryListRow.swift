import SwiftUI

enum Destination: Identifiable {
    var id: Int {
        switch self {
        case let .details(repository):
            return repository.id
        case let .user(owner):
            return owner.id
        }
    }
    
    case details(repository: Repository), user(owner: Owner)
}

struct RepositoryListRow: View {
    @State
    var repository: Repository
    var actionHandler: ((Destination) -> Void)?

    var body: some View {
        HStack {
            Button {
                actionHandler?(.user(owner: repository.owner))
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
                            .font(.system(size: 20, weight: .bold))
                            .multilineTextAlignment(.leading)
                        Text(repository.owner.login)
                            .font(.system(size: 15, weight: .medium))
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        HStack {
                            Text("\(repository.stargazersCount)")
                                .font(.system(size: 15))
                            Image(systemName: "star.fill")
                                .fixedSize()
                                .frame(width: 20)
                                .foregroundColor(.yellow)
                        }
                        HStack {
                            Text("\(repository.watchers)")
                                .font(.system(size: 15))
                            Image(systemName: "eye.fill")
                                .fixedSize()
                                .frame(width: 20)
                                .foregroundColor(.blue)
                        }
                        HStack {
                            Text("\(repository.forks)")
                                .font(.system(size: 15))
                            Image(systemName: "tuningfork")
                                .fixedSize()
                                .frame(width: 20)
                        }
                    }
                }
                .contentShape(Rectangle())
            }
        }
    }
}

struct RepositoryListRow_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryListRow(repository: Repository.mock)
    }
}
