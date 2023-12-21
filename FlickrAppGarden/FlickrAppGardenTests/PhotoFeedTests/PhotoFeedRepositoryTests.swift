import XCTest
@testable import FlickrAppGarden

final class PhotoFeedRepositoryTests: XCTestCase {

    private var networkServiceSpy: NetworkServiceProtocolSpy!

    override func setUp() {
        networkServiceSpy = NetworkServiceProtocolSpy()
    }

    func testPhotoFeedRepository_whenFetchPhotoFeedIsSuccess_thenReturnData() async {
        let photos = Photos(title: "photo", link: "", description: nil, modified: "", generator: "", items: [])
        networkServiceSpy.expectedResult = photos
        let sut = PhotoFeedRepository(service: networkServiceSpy)

        let result = await sut.fetchPhotoFeed(tags: "")

        XCTAssertTrue(networkServiceSpy.requestWasCalled)

        switch result {
        case .success(let data):
            XCTAssertEqual(photos.title, data.title)
        case .failure(_):
            XCTFail("Shouldn't receive an error.")
        }
    }

    func testPhotoFeedRepository_whenFetchPhotoFeedIsFail_thenReturnAnError() async {
        networkServiceSpy.shouldReturnError = true
        networkServiceSpy.expectedError = .noData

        let sut = PhotoFeedRepository(service: networkServiceSpy)

        let result = await sut.fetchPhotoFeed(tags: "")

        XCTAssertTrue(networkServiceSpy.requestWasCalled)

        switch result {
        case .success(_):
            XCTFail("Shouldn't receive success.")
        case .failure(let error):
            XCTAssertEqual(error, .noData)
        }
    }
}
