import SwiftUI

struct PhotoFeedView: View {

    @ObservedObject var viewState: PhotoFeedViewState

    let interactor: PhotoFeedInteractorProtocol

    var body: some View {
        NavigationStack {
            Group {
                switch viewState.state {
                case .loading:
                    ProgressView("Loading..")
                case .loaded:
                    contentView
                case .error:
                    errorContentView
                case .empty:
                    emptyContentView
                }
            }
            .navigationTitle("Gallery 🏷️")
        }
        .searchable(text: $viewState.searchValue)
        .onReceive(viewState.$searchValue.debounce(for: 0.8, scheduler: RunLoop.main)) { searchTerm in
            if !searchTerm.isEmpty {
                Task { await interactor.fetchData(with: searchTerm) }
            }
        }
        .task {
            //await interactor.fetchData(with: "apple")
        }
    }

    var contentView: some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: [.init(.adaptive(minimum: 100, maximum: .infinity), spacing: 3)], spacing: 3) {
                ForEach(0..<viewState.photos.count, id: \.self) { value in
                    NavigationLink(destination: PhotoDetailsView(details: retrievePhotoDetails(viewState.photos[value]))) {
                        PhotoFeedGridRow(imageURL: viewState.photos[value].media.imageURL ?? "")
                    }
                }
            }
        }
        .scrollIndicators(.never)
        .padding(.horizontal)
    }

    var emptyContentView: some View {
        VStack {
            Text("Sorry, there are no results.")
                .font(.title2)
            Text("Try doing a new search with other keywords.")
                .font(.body)
                .foregroundStyle(.secondary)
        }
    }

    var errorContentView: some View {
        VStack {
            Text("There's something wrong.")
                .font(.title2)
            Text("Try again soon")
                .font(.body)
                .foregroundStyle(.secondary)
        }
    }

    private func retrievePhotoDetails(_ photo: Photo) -> PhotoDetails {
        PhotoDetailsParse().modelToDetails(from: photo)
    }
}

#Preview {
    let viewState = PhotoFeedViewState()
    let presenter = PhotoFeedPresenter(viewState: viewState)
    let interactor = PhotoFeedInteractor(loader: .init(), presenter: presenter)

    return PhotoFeedView(viewState: viewState, interactor: interactor)
}
