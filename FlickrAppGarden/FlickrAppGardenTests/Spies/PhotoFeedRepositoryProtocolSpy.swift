@testable import FlickrAppGarden

final class PhotoFeedRepositoryProtocolSpy: PhotoFeedRepositoryProtocol {
    
    var fetchPhotoFeedWasCalled: Bool = false
    var expectedResult: Photos?
    var shouldReturnError: Bool = false
    var expectedError: RequestError = .unknown

    func fetchPhotoFeed(tags: String) async -> Result<Photos, RequestError> {
        fetchPhotoFeedWasCalled = true
        guard !shouldReturnError, let expectedResult else {
            return .failure(expectedError)
        }

        return .success(expectedResult)
    }
}
