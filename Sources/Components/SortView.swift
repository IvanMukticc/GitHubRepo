import SwiftUI

struct SortView: View {
    @State
    var starSort = SortBy.starsAsc
    @State
    var forkSort = SortBy.forksAsc
    @State
    var updateSort = SortBy.updatedAsc

    var actionHandler: ((SortBy) -> Void)?

    var body: some View {
        HStack {
            Text("Sort by:")
                .font(.headline)
            Spacer()

            Button {
                starSort == .starsAsc ? (starSort = .starsDes) :
                    (starSort = .starsAsc)
                actionHandler?(starSort)
            } label: {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                Image(
                    systemName: starSort == .starsAsc ? "chevron.up" :
                        "chevron.down"
                )
            }
            .sortButtonModifier()
            Spacer()

            Button {
                forkSort == .forksAsc ? (forkSort = .forksDes) :
                    (forkSort = .forksAsc)
                actionHandler?(forkSort)
            } label: {
                Image(systemName: "tuningfork")
                Image(
                    systemName: forkSort == .forksAsc ? "chevron.up" :
                        "chevron.down"
                )
            }
            .sortButtonModifier()
            Spacer()

            Button {
                updateSort == .updatedAsc ? (updateSort = .updatedDes) :
                    (updateSort = .updatedAsc)
                actionHandler?(updateSort)
            } label: {
                Image(systemName: "tray.and.arrow.up.fill")
                    .foregroundColor(.green)
                Image(
                    systemName: updateSort == .updatedAsc ? "chevron.up" :
                        "chevron.down"
                )
            }
            .sortButtonModifier()
        }
    }
}

struct SortView_Previews: PreviewProvider {
    static var previews: some View {
        SortView()
    }
}
