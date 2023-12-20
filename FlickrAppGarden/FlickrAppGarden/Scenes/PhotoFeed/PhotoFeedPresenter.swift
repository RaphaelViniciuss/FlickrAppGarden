protocol PhotoFeedPresenterProtocol {
    @MainActor func updateData(with photos: [Photo])
    @MainActor func setViewToLoading()
}

final class PhotoFeedPresenter: PhotoFeedPresenterProtocol {

    private let viewState: PhotoFeedViewState

    init(viewState: PhotoFeedViewState) {
        self.viewState = viewState
    }

    func updateData(with photos: [Photo]) {
        if photos.isEmpty {
            viewState.state = .empty
        }

        viewState.photos = photos
        viewState.state = .loaded
    }

    func setViewToLoading() {
        viewState.state = .loading
    }
}
