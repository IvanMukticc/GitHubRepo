import Foundation

class ApiManager {
    enum ApiError: Error, LocalizedError {
        case invalidURL
        case dataNotFound
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

    func getUrlRequest(searchTerm: String) throws -> URLRequest? {
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

    var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }

    func getRepositories(for search: String) async throws -> [Repository] {
        guard let urlRequest = try getUrlRequest(searchTerm: search)
        else {
            throw ApiError.badURLRequest
        }
        let (data, response) = try await URLSession.shared.data(for: urlRequest)

        guard (response as? HTTPURLResponse)?.statusCode == 200
        else {
            print("An error occured with status: \(response)")
            return []
        }

        let decoded = try decoder.decode(Root.self, from: data)
        return decoded.items ?? []
    }
}
