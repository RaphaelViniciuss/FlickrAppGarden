enum RequestError: Error {
    case decode, invalidURL, noResponse, noData, unknown
}
