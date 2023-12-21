import XCTest
@testable import FlickrAppGarden

final class PhotoFeedPresenterTests: XCTestCase {

    func testPhotoFeedPresenter_whenFeatureIsLoading_thenShouldChangeForLoadingState() async {
        let state = PhotoFeedViewState()
        let sut = PhotoFeedPresenter(viewState: state)

        await sut.setViewToLoading()

        XCTAssertTrue(state.state == .loading)
    }

    func testPhotoFeedPresenter_whenFeatureThereIsAnError_thenShouldChangeForErrorState() async {
        let state = PhotoFeedViewState()
        let sut = PhotoFeedPresenter(viewState: state)

        await sut.updateViewError()

        XCTAssertTrue(state.state == .error)
    }

    func testPhotoFeedPresenter_whenFeatureThereIsNoData_thenShouldChangeForEmptyState() async {
        let state = PhotoFeedViewState()
        state.photos = [
            .init(
                title: "",
                link: "",
                media: .init(
                    imageURL: nil
                ),
                date_taken: "",
                description: nil,
                published: "",
                author: "",
                author_id: "",
                tags: ""
            )]

        let sut = PhotoFeedPresenter(viewState: state)

        await sut.updateData(with: [])

        XCTAssertTrue(state.state == .empty)
        XCTAssertTrue(state.photos.isEmpty)
    }

    func testPhotoFeedPresenter_whenFeatureThereIsData_thenShouldChangeForLoadedStateWithData() async {
        let state = PhotoFeedViewState()
        let sut = PhotoFeedPresenter(viewState: state)
        let mockPhotos: [Photo] = [
            .init(
                title: "mock1",
                link: "",
                media: .init(
                    imageURL: nil
                ),
                date_taken: "",
                description: nil,
                published: "",
                author: "",
                author_id: "",
                tags: ""
            ),
            .init(
                title: "mock2",
                link: "",
                media: .init(
                    imageURL: nil
                ),
                date_taken: "",
                description: nil,
                published: "",
                author: "",
                author_id: "",
                tags: ""
            ),
        ]

        await sut.updateData(with: mockPhotos)

        XCTAssertTrue(state.state == .loaded)
        XCTAssertEqual(state.photos.count, mockPhotos.count)
    }
}
