struct Photos: Codable {
    let title: String
    let link: String
    let description: String?
    let modified: String
    let generator: String
    let items: [Photo]?
}
