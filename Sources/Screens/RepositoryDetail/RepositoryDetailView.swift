import SwiftUI

struct RepositoryDetailView: View {
    @ObservedObject
    var viewModel: ViewModel
    var actionHandler: ((Destination) -> Void)?

    var body: some View {
        NavigationView {
            List {
                Section {
                    Button {
                        if let url = URL(string: viewModel.repository.htmlUrl) {
                            UIApplication.shared.open(url)
                        }
                    } label: {
                        HStack {
                            Text("\(viewModel.repository.name)")
                                .textFontModifier(size: 20, weight: .bold)
                                .foregroundColor(.black)
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                        .contentShape(Rectangle())
                    }
                }

                Section("STATS") {
                    RepositoryEmojiView(type: .stars(
                        stars: viewModel.repository
                            .stargazersCount
                    ))
                    RepositoryEmojiView(type: .forks(
                        forks: viewModel.repository
                            .forks
                    ))
                    RepositoryEmojiView(type: .watchers(
                        watchers: viewModel.repository
                            .watchers
                    ))
                }

                Section("DESCRIPTION") {
                    HStack {
                        Text("Language:")
                            .font(.headline)
                        Spacer()
                        Text(viewModel.repository.language ?? "n/a")
                    }
                    VStack(alignment: .leading) {
                        Text(
                            "Details:"
                        )
                        .font(.headline)
                        Text(viewModel.repository.description ?? "n/a")
                    }
                }

                Section("DATES") {
                    HStack {
                        Text("Created at:")
                            .font(.headline)
                        Spacer()
                        Text("\(viewModel.repository.createdAt, style: .date)")
                    }
                    HStack {
                        Text("Updated at:")
                            .font(.headline)
                        Spacer()
                        Text(
                            "\(viewModel.repository.updatedAt ?? Date.now, style: .date)"
                        )
                    }
                }

                Section("OWNER") {
                    Button {
                        if let url = URL(
                            string: viewModel.repository.owner
                                .htmlUrl
                        ) {
                            UIApplication.shared.open(url)
                        }
                    } label: {
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
