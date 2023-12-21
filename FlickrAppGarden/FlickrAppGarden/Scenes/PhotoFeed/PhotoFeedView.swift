import SwiftUI

struct PhotoFeedView: View {

    @ObservedObject var viewState: PhotoFeedViewState

    let interactor: PhotoFeedInteractorProtocol

    var body: some View {
        NavigationStack {
            Group {
                switch viewState.state {
                case .loading:
                    ProgressView("photo.feed.loading.body")
                case .loaded:
                    contentView
                case .error:
                    errorContentView
                case .empty:
                    emptyContentView
                }
            }
            .navigationTitle("photo.feed.content.title")
        }
        .searchable(text: $viewState.searchValue)
        .onReceive(viewState.$searchValue.debounce(for: 0.8, scheduler: RunLoop.main)) { searchTerm in
            if !searchTerm.isEmpty {
                Task { await interactor.fetchData(with: searchTerm) }
            }
        }
        .task {
            await interactor.fetchData(with: "apple")
        }
    }

    var contentView: some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: [.init(.adaptive(minimum: 100, maximum: .infinity), spacing: 3)], spacing: 3) {
                ForEach(viewState.photos, id: \.self) { value in
                    NavigationLink(destination: PhotoDetailsView(details: retrievePhotoDetails(value))) {
                        PhotoFeedGridRow(imageURL: value.media.imageURL ?? "")
                    }
                }
            }
        }
        .scrollIndicators(.never)
        .padding(.horizontal)
    }

    var emptyContentView: some View {
        VStack {
            Text("photo.feed.empty.title")
                .font(.title2)
            Text("photo.feed.empty.body")
                .font(.body)
                .foregroundStyle(.secondary)
        }
    }

    var errorContentView: some View {
        VStack {
            Text("photo.feed.error.title")
                .font(.title2)
            Text("photo.feed.error.body")
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
    let network = NetworkService()
    let repository = PhotoFeedRepository(service: network)
    let interactor = PhotoFeedInteractor(repository: repository, presenter: presenter)

    return PhotoFeedView(viewState: viewState, interactor: interactor)
}
