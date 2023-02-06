import SwiftUI

struct UserDetailView: View {
    @StateObject
    var viewModel: ViewModel

    var body: some View {
        NavigationView {
            List {
                Section {
                    Text("\(viewModel.owner.login)")
                }

                Section("COUNTS") {
                    DetailEmojiView(type: .followers(
                        followers: viewModel.owner
                            .followers ?? 0
                    ))
                    DetailEmojiView(type: .following(
                        following: viewModel.owner
                            .following ?? 0
                    ))
                    DetailEmojiView(type: .publicRepos(
                        publicRepos: viewModel
                            .owner.publicRepos ?? 0
                    ))
                }

                Section("PERSONAL") {
                    PersonalDetailView(type: .name(
                        name: viewModel.owner
                            .name ?? "n/a"
                    ))
                    PersonalDetailView(type: .email(
                        email: viewModel.owner
                            .email ?? "n/a"
                    ))
                    PersonalDetailView(type: .location(
                        location: viewModel.owner
                            .location ?? "n/a"
                    ))
                }

                Section("BIO") {
                    Text("\(viewModel.owner.bio ?? "n/a")")
                }

                Section("REPOSITORIES") {
                    ForEach(
                        viewModel.repositories
                    ) { repository in
                        Button {
                            if let url = URL(string: repository.htmlUrl) {
                                UIApplication.shared.open(url)
                            }
                        } label: {
                            HStack {
                                Text(repository.name)
                                    .font(.headline)
                                    .foregroundColor(.black)
                                Spacer()
                                Text(repository.language ?? "n/a")
                                    .foregroundColor(.black)
                                Image(systemName: "greaterthan")
                            }
                        }
                    }
                }
            }
            .onAppear {
                Task {
                    let request = try ApiManager
                        .getUrlRequest(user: viewModel.owner.login)
                    viewModel.repositories = try await ApiManager
                        .fetch(
                            type: [Repository].self,
                            with: request
                        )
                }
            }
            .navigationTitle("Owner")
        }
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailView(viewModel: UserDetailView.ViewModel(owner: Owner.mock))
    }
}
