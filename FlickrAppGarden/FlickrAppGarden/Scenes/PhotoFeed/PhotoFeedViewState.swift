import SwiftUI

enum PhotoFeedState {
    case loading
    case loaded
    case error
    case empty
}

final class PhotoFeedViewState: ObservableObject {
    @Published var state: PhotoFeedState = .empty
    @Published var photos: [Photo] = []
    @Published var searchValue = ""
}
