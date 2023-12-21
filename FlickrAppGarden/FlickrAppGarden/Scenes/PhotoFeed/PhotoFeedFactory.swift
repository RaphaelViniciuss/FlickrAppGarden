final class PhotoFeedFactory {

    func make(networkService: NetworkServiceProtocol) -> PhotoFeedView {
        let viewState = PhotoFeedViewState()
        let presenter = PhotoFeedPresenter(viewState: viewState)
        let repository = PhotoFeedRepository(service: networkService)
        let interactor = PhotoFeedInteractor(repository: repository, presenter: presenter)
        return PhotoFeedView(viewState: viewState, interactor: interactor)
    }
}
