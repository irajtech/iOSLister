//
//  Service.swift
//  Lister
//
//  Created by Rajkumar Kothandaraman on 05/03/2021.
//

import Foundation

public enum ServiceError: Error, LocalizedError {

    case unauthorized,
        custom(String),
        server(httpResponse: HTTPURLResponse?, error: Error?),
        parsing(httpResponse: HTTPURLResponse?, error: Error?)

    public var errorDescription: String {
        switch self {
        case .unauthorized:
            return "UnAuthorised"
        case .custom(let text):
            return "Error: \(text)"
        case .server(let httpResponse, let error), .parsing(let httpResponse, let error):
            guard let httpResponse = httpResponse else {
                return "No response from the server"
            }

            guard let error = error else {
                return "No error details returnerd"
            }

            return "Error with code: \(httpResponse.statusCode), error: \(error.localizedDescription)"
        }
    }
}

public enum ResultType<T> {
    case success(T)
    case failure(Error?)
}

open class Service<T: Decodable> {


    @discardableResult
    public static func perform(_ resource: Resource, decoder: JSONDecoder = JSONDecoder(), completion: @escaping (ResultType<T>) -> ()) -> URLSessionDataTask {

        let session = URLSession(configuration: URLSessionConfiguration.default)

        return
         session.dataTask(with: request(resource: resource)) { (data, response, error) in

            guard let httpResponse = response as? HTTPURLResponse, error == nil else {
                completion(ResultType.failure(ServiceError.server(httpResponse: nil, error: error)))
                return
            }

            switch httpResponse.statusCode {
            case 204:
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: ["success": true], options: [])
                    let result = try JSONDecoder().decode(T.self, from: jsonData)
                    completion(.success(result))
                } catch let error {
                    completion(.failure(ServiceError.parsing(httpResponse: httpResponse, error: error)))
                }
                break
            case 200 ... 299:
                if let data = data {
                    do {
                        let result = try decoder.decode(T.self, from: data)
                        completion(.success(result))
                    } catch let error {
                        completion(.failure(ServiceError.parsing(httpResponse: httpResponse, error: error)))
                    }
                }
                break
            default:
                if httpResponse.statusCode == 401 {
                    completion(ResultType.failure(ServiceError.unauthorized))
                } else if (httpResponse.statusCode == 422 && data != nil && error == nil) {
                    if let data = data {
                        do {
                            let result = try decoder.decode(T.self, from: data)
                            completion(.success(result))
                        } catch let error {
                            completion(.failure(ServiceError.parsing(httpResponse: httpResponse, error: error)))
                        }
                    }
                } else {
                    completion(ResultType.failure(ServiceError.server(httpResponse: httpResponse, error: error)))
                }
                break
            }
        }
    }
}
