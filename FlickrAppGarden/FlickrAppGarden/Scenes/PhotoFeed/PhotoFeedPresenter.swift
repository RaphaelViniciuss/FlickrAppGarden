protocol PhotoFeedPresenterProtocol {
    @MainActor func updateData(with photos: [Photo])
    @MainActor func setViewToLoading()
    @MainActor func updateViewError()
}

final class PhotoFeedPresenter: PhotoFeedPresenterProtocol {

    private let viewState: PhotoFeedViewState

    init(viewState: PhotoFeedViewState) {
        self.viewState = viewState
    }

    func updateData(with photos: [Photo]) {
        viewState.photos = photos
        viewState.state = photos.isEmpty ? .empty : .loaded
    }

    func setViewToLoading() {
        viewState.state = .loading
    }

    func updateViewError() {
        viewState.state = .error
    }
}
