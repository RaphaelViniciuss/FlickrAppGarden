import SwiftUI

typealias GridAccessibility = (position: Int?, total: Int, title: String)

struct PhotoFeedView: View {

    @ObservedObject var viewState: PhotoFeedViewState

    let interactor: PhotoFeedInteractorProtocol

    var body: some View {
        NavigationStack {
            Group {
                switch viewState.state {
                case .loading:
                    loadingView
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

    private var loadingView: some View { 
        ProgressView("photo.feed.loading.body")
            .onAppear() {
                triggerAccessbilityNotification()
            }
    }

    private var contentView: some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: [
                .init(.adaptive(minimum: Metrics.gridItemMinimum, maximum: .infinity), spacing: Metrics.gridSpacing)
            ], spacing: Metrics.gridSpacing) {
                ForEach(viewState.photos, id: \.self) { photo in
                    NavigationLink(destination: PhotoDetailsView(details: retrievePhotoDetails(photo))) {
                        let label = setupAccessibilityForGrid(photo)
                        PhotoFeedGridRow(imageURL: photo.media.imageURL ?? "")
                            .accessibilityLabel(
                                Text("photo.feed.accessibility.photo \(label.position ?? .zero) \(label.total) \(label.title)")
                            )
                    }
                }
            }
        }
        .scrollIndicators(.never)
        .padding(.horizontal)
        .onAppear() {
            triggerAccessbilityNotification()
        }
    }

    private var emptyContentView: some View {
        VStack {
            Text("photo.feed.empty.title")
                .font(.title2)
            Text("photo.feed.empty.body")
                .font(.body)
                .foregroundStyle(.secondary)
        }
        .onAppear() {
            triggerAccessbilityNotification()
        }
    }

    private var errorContentView: some View {
        VStack {
            Text("photo.feed.error.title")
                .font(.title2)
            Text("photo.feed.error.body")
                .font(.body)
                .foregroundStyle(.secondary)
        }
        .onAppear() {
            triggerAccessbilityNotification()
        }
    }

    private func retrievePhotoDetails(_ photo: Photo) -> PhotoDetails {
        PhotoDetailsParse().modelToDetails(from: photo)
    }

    private func setupAccessibilityForGrid(_ photo: Photo) -> GridAccessibility {
        let position = viewState.photos.firstIndex(of: photo)
        let total = viewState.photos.count
        return (position, total, photo.title)
    }

    private func triggerAccessbilityNotification(_ notification: UIAccessibility.Notification = .screenChanged) {
        UIAccessibility.post(notification: notification, argument: self)
    }
}

extension PhotoFeedView {
    struct Metrics {
        static let gridItemMinimum: CGFloat = 100
        static let gridSpacing: CGFloat = 3
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
