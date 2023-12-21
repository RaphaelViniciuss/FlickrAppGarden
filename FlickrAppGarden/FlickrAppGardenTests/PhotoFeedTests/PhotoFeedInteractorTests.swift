import XCTest
@testable import FlickrAppGarden

final class PhotoFeedInteractorTests: XCTestCase {

    private var presenterSpy: PhotoFeedPresenterProtocolSpy!
    private var repositorySpy: PhotoFeedRepositoryProtocolSpy!

    override func setUp() {
        presenterSpy =  PhotoFeedPresenterProtocolSpy()
        repositorySpy = PhotoFeedRepositoryProtocolSpy()
    }

    func testPhotoFeedInteractor_whenFetchDataSucessWithEmptyData_thenShouldCallPresenter() async {
        let sut = PhotoFeedInteractor(repository: repositorySpy, presenter: presenterSpy)

        let mock = Photos(title: "", link: "", description: nil, modified: "", generator: "", items: [])
        repositorySpy.expectedResult = mock

        await sut.fetchData(with: "tags")

        XCTAssertTrue(repositorySpy.fetchPhotoFeedWasCalled)
        XCTAssertTrue(presenterSpy.updateDataWasCalled)
        XCTAssertTrue(presenterSpy.currentPhotos.isEmpty)
    }

    func testPhotoFeedInteractor_whenFetchDataSucessWithData_thenShouldCallPresenter() async {
        let sut = PhotoFeedInteractor(repository: repositorySpy, presenter: presenterSpy)

        let mockPhotoItems: [Photo] = [
            makeMockPhoto(title: "Photo1"),
            makeMockPhoto(title: "Photo2")
        ]
        let mockPhotos = Photos(title: "", link: "", description: nil, modified: "", generator: "", items: mockPhotoItems)
        repositorySpy.expectedResult = mockPhotos

        await sut.fetchData(with: "tags")

        XCTAssertTrue(repositorySpy.fetchPhotoFeedWasCalled)
        XCTAssertTrue(presenterSpy.updateDataWasCalled)
        XCTAssertEqual(presenterSpy.currentPhotos.count, mockPhotoItems.count)
    }

    func testPhotoFeedInteractor_whenFetchDataFail_thenShouldCallPresenter() async {
        let sut = PhotoFeedInteractor(repository: repositorySpy, presenter: presenterSpy)
        repositorySpy.shouldReturnError = true

        await sut.fetchData(with: "tags")

        XCTAssertTrue(repositorySpy.fetchPhotoFeedWasCalled)
        XCTAssertTrue(presenterSpy.updateViewErrorWasCalled)
        XCTAssertTrue(presenterSpy.currentPhotos.isEmpty)
    }
}

extension PhotoFeedInteractorTests {
    private func makeMockPhoto(
        title: String = "",
        link: String = "",
        imageURL: String = "",
        date_taken: String = "",
        description: String? = nil,
        published: String = "",
        author: String = "",
        author_id: String = "",
        tags: String = ""
    ) -> Photo {
        .init(
            title: title,
            link: link,
            media: .init(imageURL: imageURL),
            date_taken: date_taken,
            description: description,
            published: published,
            author: author,
            author_id: author_id,
            tags: tags
        )
    }
}
