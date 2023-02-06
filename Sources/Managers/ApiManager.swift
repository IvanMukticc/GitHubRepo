import Foundation

class ApiManager {
    enum ApiError: Error, LocalizedError {
        case invalidURL
        case dataNotFound(description: String)
        case badURLRequest

        var errorDescription: String? {
            switch self {
            case .invalidURL:
                return "Invalid URL!"
            case .dataNotFound:
                return ""
            case .badURLRequest:
                return "Bad URLRequest!"
            }
        }
    }

    static var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }

    static func getUrlRequest(user: String) throws -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.github.com"
        urlComponents.path = "/users/\(user)/repos"

        guard let url = urlComponents.url else {
            throw ApiError.invalidURL
        }

        return URLRequest(url: url)
    }

    static func getUrlRequest(searchTerm: String) throws -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.github.com"
        urlComponents.path = "/search/repositories"
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: searchTerm)
        ]

        guard let url = urlComponents.url else {
            throw ApiError.invalidURL
        }

        return URLRequest(url: url)
    }

    static func getUrlRequest(url: String) throws -> URLRequest {
        let url = URL(string: url)
        guard let url = url else {
            throw ApiError.invalidURL
        }
        return URLRequest(url: url)
    }

    static func fetch<T: Codable>(
        type: T.Type,
        with request: URLRequest
    ) async throws -> T {
        let (data, response) = try await URLSession.shared.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 200
        else {
            throw ApiError.badURLRequest
        }
        do {
            return try decoder.decode(type, from: data)
        } catch {
            throw ApiError.dataNotFound(description: error.localizedDescription)
        }
    }
}
