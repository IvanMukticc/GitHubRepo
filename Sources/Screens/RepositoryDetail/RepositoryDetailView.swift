import SwiftUI

struct RepositoryDetailView: View {
    @ObservedObject
    var viewModel: ViewModel
    var actionHandler: ((Destination) -> Void)?

    var body: some View {
        NavigationView {
            List {
                Section {
                    HStack {
                        Text("\(viewModel.repository.name)")
                            .textFontModifier(size: 20, weight: .bold)
                        Spacer()
                        Image(systemName: "greaterthan")
                    }
                    .contentShape(Rectangle())
                }
                .onTapGesture {
                    if let url = URL(string: viewModel.repository.htmlUrl) {
                        UIApplication.shared.open(url)
                    }
                }
                Section("COUNTS") {
                    HStack(alignment: .firstTextBaseline) {
                        Text("⭐️")
                            .countsTextModifier()
                        Text("stars".capitalized)
                        Spacer()
                        Text("\(viewModel.repository.stargazersCount)")
                    }
                    HStack {
                        Text("⫚")
                            .countsTextModifier()
                        Text("Forks")
                        Spacer()
                        Text("\(viewModel.repository.forks)")
                    }
                    HStack {
                        Text("👀")
                            .countsTextModifier()
                        Text("Watchers")
                        Spacer()
                        Text("\(viewModel.repository.watchers)")
                    }
                }
                Section("DESCRIPTION") {
                    Text("Language: \(viewModel.repository.language ?? "n/a")")
                        .textFontModifier(size: 20, weight: .semibold)
                    Text(
                        "Details: \(viewModel.repository.description ?? "n/a")"
                    )
                    .font(.title2)
                }

                Section("DATES") {
                    Text(
                        "Created at: \(viewModel.repository.createdAt, style: .date)"
                    )
                    .font(.headline)
                    Text(
                        "Updated at: \(viewModel.repository.updatedAt ?? Date.now, style: .date)"
                    )
                    .font(.headline)
                }

                Section("OWNER") {
                    HStack {
                        Text("\(viewModel.repository.owner.login)")
                            .textFontModifier(size: 30, weight: .bold)
                            .foregroundColor(.white)
                    }
                    .frame(minHeight: 100)
                    .background {
                        ZStack {
                            AsyncImage(url: URL(
                                string: viewModel.repository.owner
                                    .avatarUrl
                            )) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                            } placeholder: {
                                Color.gray
                            }
                            .scaledToFill()
                            .blur(radius: 10)
                            Color(.black)
                                .opacity(0.3)
                        }
                        .frame(width: 700, height: 150)
                    }
                }
                .onTapGesture {
                    guard let url = URL(
                        string: viewModel.repository.owner
                            .htmlUrl
                    )
                    else {
                        return
                    }
                    UIApplication.shared.open(url)
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Repository")
        }
    }
}

struct RepositoryDetailViewView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryDetailView(viewModel: .init(repository: Repository.mock))
    }
}
