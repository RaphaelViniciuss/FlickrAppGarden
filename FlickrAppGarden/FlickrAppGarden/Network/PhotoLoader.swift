// TODO: - Build a network layer -

import Foundation

enum PhotoLoaderError: Error {
    case parse
}

struct PhotoLoader {
    private var session = URLSession.shared
    private let baseURL = "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1&tags="

    func loadPhoto(tags params: String) async throws -> Photos {
        guard let url = URL(string: baseURL+params) else { throw PhotoLoaderError.parse }
       
        let (data, _) = try await session.data(from: url)
        return try JSONDecoder().decode(Photos.self, from: data)
    }
}
