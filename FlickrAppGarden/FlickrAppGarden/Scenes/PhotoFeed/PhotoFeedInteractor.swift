import Foundation

protocol PhotoFeedInteractorProtocol {
    @MainActor func fetchData(with tags: String) async
}

final class PhotoFeedInteractor: PhotoFeedInteractorProtocol {
    
    private let loader: PhotoLoader
    private let presenter: PhotoFeedPresenterProtocol

    init(loader: PhotoLoader, presenter: PhotoFeedPresenterProtocol) {
        self.loader = loader
        self.presenter = presenter
    }

    func fetchData(with tags: String) async {
        presenter.setViewToLoading()

        do {
            let data = try await loader.loadPhoto(tags: tags)
            presenter.updateData(with: data.items ?? [])
        } catch {
            presenter.updateViewError()
        }
    }
}
