import Foundation

class ApiManager {
    static let shared = ApiManager()

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

    var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }

    func fetch<T: Codable>(
        type: T.Type,
        endpoint: Endpoint
    ) async throws -> T {
        let (data, response) = try await URLSession.shared
            .data(for: endpoint.request)
        guard (response as? HTTPURLResponse)?.statusCode == 200
        else {
            throw ApiError.badURLRequest
        }
        do {
            return try ApiManager.shared.decoder.decode(type, from: data)
        } catch {
            print(error)
            throw ApiError.dataNotFound(description: error.localizedDescription)
        }
    }

    enum Endpoint {
        case users(user: String)
        case searchRepositories(query: String)
        case userRepository(userLogin: String)

        var request: URLRequest {
            var urlComponents = URLComponents()
            urlComponents.scheme = "https"
            urlComponents.host = "api.github.com"

            switch self { case let .users(user: user):
                urlComponents.path = "/users/\(user)"
            case let .searchRepositories(query: query):
                urlComponents.path = "/search/repositories"
                urlComponents
                    .queryItems = [URLQueryItem(name: "q", value: query)]
            case let .userRepository(userLogin: userLogin):
                urlComponents.path = "/users/\(userLogin)/repos"
            }

            guard let url = urlComponents.url else {
                fatalError(
                    "Whoops, seems like there is some faulty data when trying to create url!!"
                )
            }
            return URLRequest(url: url)
        }
    }
}
