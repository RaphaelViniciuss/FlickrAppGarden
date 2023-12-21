@testable import FlickrAppGarden

final class NetworkServiceProtocolSpy: NetworkServiceProtocol {
    
    var requestWasCalled: Bool = false
    var expectedResult: Codable?
    var shouldReturnError: Bool = false
    var expectedError: RequestError = .unknown
    var receivedEndpoint: Endpoint?

    func request<T>(endpoint: Endpoint, responseModel: T.Type) async -> Result<T, RequestError> where T: Codable {
        requestWasCalled = true
        guard !shouldReturnError, let expectedResult = expectedResult as? T else {
            return .failure(expectedError)
        }

        return .success(expectedResult)
    }
}
