struct Photo: Codable {
    let title: String
    let link: String
    let media: PhotoMedia
    let date_taken: String
    let description: String?
    let published: String
    let author: String
    let author_id: String
    let tags: String
}
