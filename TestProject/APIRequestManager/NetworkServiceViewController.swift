import Alamofire

enum APIError: Error {
    case noInternet
    case invalidResponse
    case requestFailed(Error)
    case decodingFailed(Error)
}

class NetworkService {
    static let isInternetAvailable: Bool = {
        return NetworkReachabilityManager()?.isReachable ?? false
    }()
    
    static let defaultHeaders: HTTPHeaders = [
        "Authorization": "Bearer YourAccessToken",
        "Content-Type": "application/json"
    ]

    static func request<T: Codable>(
        _ endpoint: String,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        headers: HTTPHeaders? = defaultHeaders,
        completion: @escaping (Result<T, APIError>) -> Void
    ) {
        guard isInternetAvailable else {
            print("No internet connection")
            completion(.failure(.noInternet))
            return
        }
        
        AF.request(endpoint, method: method, parameters: parameters, headers: headers)
            .validate()
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let decodedObject):
                    completion(.success(decodedObject))
                case .failure(let error):
                    if let statusCode = response.response?.statusCode, (400...599).contains(statusCode) {
                        completion(.failure(.requestFailed(error)))
                    } else {
                        completion(.failure(.decodingFailed(error)))
                    }
                }
            }
    }
}
