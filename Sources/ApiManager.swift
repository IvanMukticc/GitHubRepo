import Foundation

class ApiManager: ObservableObject {
    var searchTerm = "laravel"

//    init(searchTerm: String) {
//        self.searchTerm = searchTerm
//    }

    enum ApiError: Error, LocalizedError {
        case invalidURL
        case dataNotFound
        case decodingError
    }

    var endPointURL: String {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.github.com"
        urlComponents.path = "/search/repositories"
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: searchTerm)
        ]

        return urlComponents.url?.absoluteString ?? "N/A"
    }

    var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }

    func sendRequest(completion: @escaping ([Repository]?, ApiError?) -> Void) {
        guard let url = URL(string: endPointURL) else {
            completion(nil, .invalidURL)
            return
        }

        let request = URLRequest(url: url)

        let task = URLSession.shared
            .dataTask(with: request) { data, response, error in
                guard
                    let data = data,
                    let response = response as? HTTPURLResponse,
                    200 ..< 300 ~= response.statusCode,
                    error == nil
                else {
                    completion(nil, .dataNotFound)
                    return
                }

                do {
                    let decodedData = try self.decoder
                        .decode(Root.self, from: data)
                    completion(decodedData.items, nil)
                    print(decodedData.items?.count ?? 0)
                } catch {
                    completion(nil, .decodingError)
                }
            }
        task.resume()
    }
}
