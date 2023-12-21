protocol PhotoFeedRepositoryProtocol {
    func fetchPhotoFeed(tags: String) async -> Result<Photos, RequestError>
}

final class PhotoFeedRepository: PhotoFeedRepositoryProtocol {

    private let service: NetworkServiceProtocol

    init(service: NetworkServiceProtocol) {
        self.service = service
    }

    func fetchPhotoFeed(tags: String) async -> Result<Photos, RequestError> {
        let params: [String: String] = [
            "format": "json",
            "nojsoncallback": "1",
            "tags": tags
        ]
        
        let endpoint = Endpoint(path: "/services/feeds/photos_public.gne", method: .get, parameters: params)

        return await service.request(endpoint: endpoint, responseModel: Photos.self)
    }
}
