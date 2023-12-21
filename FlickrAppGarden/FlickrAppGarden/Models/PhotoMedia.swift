struct PhotoMedia: Codable, Hashable {
    let imageURL: String?

    enum CodingKeys: String, CodingKey {
        case imageURL = "m"
    }
}
