typealias PhotoDetailsSizing = (width: String, height: String)

struct PhotoDetailsParse {
    func modelToDetails(from photo: Photo) -> PhotoDetails {
        let sizing = retrieveSizing(photo.description)

        return .init(
            title: photo.title,
            author: retrieveAuthor(photo.author),
            published: photo.published,
            imageUrl: photo.media.imageURL,
            alt: retrieveAlt(photo.description),
            width: sizing.width,
            height: sizing.height,
            tags: photo.tags
        )
    }

    private func retrieveSizing(_ description: String?) -> PhotoDetailsSizing {
        guard let description,
              let firstIndexWidth = description.firstRange(of: "width=\"")?.upperBound,
              let lastIndexWidth = description.firstRange(of: "\" height")?.lowerBound,
              let firstIndexHeight = description.firstRange(of: "height=\"")?.upperBound,
              let lastIndexHeight = description.firstRange(of: "\" alt")?.lowerBound else {
            return ("0", "0")
        }

        let width = String(description[firstIndexWidth..<lastIndexWidth])
        let height = String(description[firstIndexHeight..<lastIndexHeight])

        return(width, height)
    }

    private func retrieveAuthor(_ author: String) -> String {
        guard let firstIndex = author.firstRange(of: "(\"")?.upperBound,
              let lastIndex = author.firstRange(of: "\")")?.lowerBound else {
            return ""
        }

        return String(author[firstIndex..<lastIndex])
    }

    private func retrieveAlt(_ description: String?) -> String? {
        guard let description,
              let firstIndex = description.firstRange(of: "alt=\"")?.upperBound,
              let lastIndex = description.firstRange(of: "\" /></a>")?.lowerBound else {
            return nil
        }

        return String(description[firstIndex..<lastIndex])
    }
}

