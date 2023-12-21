import Foundation

protocol NetworkServiceProtocol {
    func request<T: Codable>(endpoint: Endpoint, responseModel: T.Type) async -> Result<T, RequestError>
}

final class NetworkService: NetworkServiceProtocol {

    func request<T>(endpoint: Endpoint, responseModel: T.Type) async -> Result<T, RequestError> where T: Codable {

        var components = URLComponents()
        components.host = endpoint.host ?? NetworkConstants.baseURL
        components.scheme = endpoint.scheme.rawValue
        components.path = endpoint.path

        if let parameters = endpoint.parameters {
            components.queryItems = parameters.compactMap { param -> URLQueryItem in
                    .init(name: param.key, value: param.value)
            }
        }

        guard let url = components.url else { return .failure(.invalidURL) }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header

        do {
            return try await triggerRequest(request)
        } catch {
            return .failure(error as? RequestError ?? .unknown)
        }
    }

    private func triggerRequest<T: Codable>(_ request: URLRequest) async throws -> Result<T, RequestError> {
        let session = URLSession(configuration: .default)

        return try await withCheckedThrowingContinuation { continuation in
            let dataTask = session.dataTask(with: request) { data, response, error in
                if let error {
                    return continuation.resume(with: .failure(error))
                }

                if response == nil {
                    return continuation.resume(with: .failure(RequestError.noResponse))
                }

                guard let data else {
                    return continuation.resume(with: .failure(RequestError.noData))
                }

                do {
                    let object = try JSONDecoder().decode(T.self, from: data)
                    DispatchQueue.main.async {
                        return continuation.resume(with: .success(Result.success(object)))
                    }
                } catch {
                    return continuation.resume(with: .failure(RequestError.decode))
                }
            }
            dataTask.resume()
        }
    }
}
