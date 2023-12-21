import Foundation

protocol PhotoFeedInteractorProtocol {
    @MainActor func fetchData(with tags: String) async
}

final class PhotoFeedInteractor: PhotoFeedInteractorProtocol {

    private let repository: PhotoFeedRepositoryProtocol
    private let presenter: PhotoFeedPresenterProtocol

    init(repository: PhotoFeedRepositoryProtocol, presenter: PhotoFeedPresenterProtocol) {
        self.repository = repository
        self.presenter = presenter
    }

    func fetchData(with tags: String) async {
        presenter.setViewToLoading()

        let result = await repository.fetchPhotoFeed(tags: tags)

        switch result {
        case .success(let data):
            presenter.updateData(with: data.items ?? [])
        case .failure(_):
            presenter.updateViewError()
        }
    }
}
