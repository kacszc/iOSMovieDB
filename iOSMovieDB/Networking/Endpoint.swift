//
//  Endpoint.swift
//  iOSMovieDB
//
//  Created by Kacper Szczepankiewicz on 03/12/2023.
//

import Foundation

protocol Endpoint {
    associatedtype Model: Decodable

    var path: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var parametersEncoding: ParameterEncoding { get }
    var baseURL: URL { get }
    var url: URL { get }

    func buildURLRequest() -> URLRequest
}

extension Endpoint {
    var method: HTTPMethod {
        .get
    }

    var baseURL: URL {
        URL(string: APIDetails.baseURL)!
    }

    var url: URL {
        baseURL.appendingPathComponent(path)
    }

    func buildURLRequest() -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        request.setHeaders(headers: ["Authorization": "Bearer \(APIDetails.accessToken)"])

        if let headers = headers {
            request.setHeaders(headers: headers)
        }

        request.encode(with: parametersEncoding)

        return request
    }
}
