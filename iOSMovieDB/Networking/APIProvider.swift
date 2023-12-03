//
//  NetworkClient.swift
//  iOSMovieDB
//
//  Created by Kacper Szczepankiewicz on 03/12/2023.
//

import Foundation

class APIProvider: NetworkProvider {
    func executeRequest<T>(route: T) async throws -> T.Model where T : Endpoint {
        let request = route.buildURLRequest()

        return try await withCheckedThrowingContinuation { continuation in
            URLSession.shared.dataTask(with: request) { data, response, error in
                let httpResponseCode = (response as? HTTPURLResponse)?.statusCode ?? 999

                if httpResponseCode != 200 {
                    continuation.resume(throwing: NetworkError.wrongStatusCode)
                    return
                }
                
                if let data {
                    guard
                        let response = try? JSONDecoder().decode(T.Model.self, from: data)
                    else {
                        continuation.resume(throwing: NetworkError.decodingError)
                        return
                    }
                    
                    continuation.resume(returning: response)
                } else if let error {
                    continuation.resume(throwing: error)
                }
            }.resume()
        }
    }
}
