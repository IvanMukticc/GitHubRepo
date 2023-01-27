import Foundation
import Kingfisher

class ApiManager {
    enum ApiError: Error, LocalizedError {
        case invalidURL
        case dataNotFound
        case decodingError
    }

    func getUrlRequest(searchTerm: String) -> URLRequest? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.github.com"
        urlComponents.path = "/search/repositories"
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: searchTerm)
        ]

        guard let url = urlComponents.url else {
            return nil
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
        guard let urlRequest = getUrlRequest(searchTerm: search)
        else {
            return []
        }
        let (data, response) = try await URLSession.shared.data(for: urlRequest)

        guard (response as? HTTPURLResponse)?.statusCode == 200
        else {
            throw ApiError.dataNotFound
        }

        let decoded = try decoder.decode(Root.self, from: data)
        print(decoded.items?.count ?? 0)
        return decoded.items ?? []
    }
}
