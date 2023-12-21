import XCTest
@testable import FlickrAppGarden

final class PhotoDetailsParseTests: XCTestCase {

    func testPhotoDetailsParse_whenParsePhotoToDetails_thenShouldReturnDetailsModel() {
        let photo = Photo(
            title: "title",
            link: "link",
            media: .init(imageURL: "imageURL"),
            date_taken: "date_taken",
            description: "<p><a />title=\"John Doe-31234123.jpg\"><img src=\"https://live.staticflickr.com/1234/908132657973_m.jpg\" width=\"240\" height=\"160\" alt=\"John Doe-31234123.jpg\" /></a></p> ",
            published: "published",
            author: "nobody@flickr.com (\"John Doe\")",
            author_id: "author_id",
            tags: "tags"
        )

        let sut = PhotoDetailsParse()

        let details = sut.modelToDetails(from: photo)

        XCTAssertEqual(details.width, "240")
        XCTAssertEqual(details.height, "160")
        XCTAssertEqual(details.author, "John Doe")
        XCTAssertEqual(details.title, photo.title)
        XCTAssertEqual(details.published, photo.published)
        XCTAssertEqual(details.imageUrl, photo.media.imageURL)
        XCTAssertEqual(details.tags, photo.tags)
    }
}
