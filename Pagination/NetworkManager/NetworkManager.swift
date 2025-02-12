//
//  NetworkManager.swift
//  Pagination
//
//

import Foundation


struct NetworkManager {
    
    
    func fetchData<T: Decodable>(from url: URL, model: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // Check HTTP response status
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200..<300:
                    if let data {
                        do {
                        let decodedData = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(decodedData))
                    } catch {
                        completion(.failure(error))
                    }
                }
                default:
                    let statusError = NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "Server Error"])
                    completion(.failure(statusError))
                }
            }
        }
        .resume()
    }
    
    func fetchData<T: Decodable>(from url: URL) async throws -> T {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse,
                (200..<300).contains(httpResponse.statusCode) else {
              let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
              throw NSError(domain: "", code: statusCode, userInfo: [NSLocalizedDescriptionKey: "Server Error"])
          }
          
          do {
              let decodedData = try JSONDecoder().decode(T.self, from: data)
              return decodedData
          } catch {
              throw error
          }
    }

}
