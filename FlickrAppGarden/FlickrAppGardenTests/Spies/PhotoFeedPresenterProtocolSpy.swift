@testable import FlickrAppGarden

final class PhotoFeedPresenterProtocolSpy: PhotoFeedPresenterProtocol {

    var updateDataWasCalled: Bool = false
    var setViewToLoadingWasCalled: Bool = false
    var updateViewErrorWasCalled: Bool = false

    var currentPhotos: [Photo] = []

    func updateData(with photos: [Photo]) {
        updateDataWasCalled = true
        currentPhotos = photos
    }
    
    func setViewToLoading() {
        setViewToLoadingWasCalled = true
    }
    
    func updateViewError() {
        updateViewErrorWasCalled = true
    }
}
