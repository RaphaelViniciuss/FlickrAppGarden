struct Endpoint {
    let scheme: RequestScheme
    let host: String?
    let path: String
    let method: HTTPMethod
    let header: [String: String]?
    let parameters: [String: String]?

    init(
        scheme: RequestScheme = .https,
        host: String? = nil,
        path: String,
        method: HTTPMethod,
        header: [String : String]? = nil,
        parameters: [String : String]? = nil
    ) {
        self.scheme = scheme
        self.host = host
        self.path = path
        self.method = method
        self.header = header
        self.parameters = parameters
    }
}
