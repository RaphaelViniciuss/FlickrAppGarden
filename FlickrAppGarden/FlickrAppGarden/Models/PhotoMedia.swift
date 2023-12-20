struct PhotoMedia: Codable {
    let imageURL: String?

    enum CodingKeys: String, CodingKey {
        case imageURL = "m"
    }
}
