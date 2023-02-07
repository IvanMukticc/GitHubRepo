import SwiftUI

struct SortView: View {
    @ObservedObject
    var viewModel = RepositoryListView.ViewModel()

    var body: some View {
        if !viewModel.repositories.isEmpty {
            HStack {
                Text("Sort by:")
                    .font(.headline)
                Spacer()

                Button {
                    if viewModel.starSort == .starsAsc {
                        viewModel.starSort = .starsDes
                    } else {
                        viewModel.starSort = .starsAsc
                    }
                    viewModel.sortList(by: viewModel.starSort)
                } label: {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Image(
                        systemName: viewModel
                            .starSort == .starsAsc ? "chevron.up" :
                            "chevron.down"
                    )
                }
                .sortButtonModifier()
                Spacer()

                Button {
                    if viewModel.forkSort == .forksAsc {
                        viewModel.forkSort = .forksDes
                    } else {
                        viewModel.forkSort = .forksAsc
                    }
                    viewModel.sortList(by: viewModel.forkSort)
                } label: {
                    Image(systemName: "tuningfork")
                    Image(
                        systemName: viewModel
                            .forkSort == .forksAsc ? "chevron.up" :
                            "chevron.down"
                    )
                }
                .sortButtonModifier()
                Spacer()

                Button {
                    if viewModel.updateSort == .updatedAsc {
                        viewModel.updateSort = .updatedDes
                    } else {
                        viewModel.updateSort = .updatedAsc
                    }
                    viewModel.sortList(by: viewModel.updateSort)
                } label: {
                    Image(systemName: "tray.and.arrow.up.fill")
                        .foregroundColor(.green)
                    Image(
                        systemName: viewModel
                            .updateSort == .updatedAsc ? "chevron.up" :
                            "chevron.down"
                    )
                }
                .sortButtonModifier()
            }
        }
    }
}

struct SortView_Previews: PreviewProvider {
    static var previews: some View {
        SortView()
    }
}
