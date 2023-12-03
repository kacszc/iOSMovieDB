//
//  ParameterEncoding.swift
//  iOSMovieDB
//
//  Created by Kacper Szczepankiewicz on 03/12/2023.
//

import Foundation

public enum ParameterEncoding {
    case urlEncoding(urlParameters: RequestParameters)
    
    public func encode(urlRequest: inout URLRequest) {
        switch self {
        case .urlEncoding(let params):
            URLParameterEncoder(urlParameters: params).encode(urlRequest: &urlRequest)
        }
    }
}

public struct URLParameterEncoder: ParameterEncoder {
    public var parameters: RequestParameters
    public var headers: HTTPHeaders = [:]

    init(urlParameters: RequestParameters) {
        self.parameters = urlParameters
    }

    public func encode(urlRequest: inout URLRequest) {
        guard 
            let url = urlRequest.url
        else {
            return
        }

        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
            urlComponents.queryItems = [URLQueryItem]()

            for (key, value) in parameters {
                var tmpValue: String?

                if let elem = value as? [Int] {
                    tmpValue = elem.map(String.init).joined(separator: ",")
                } else if let elem = value as? [String] {
                    tmpValue = elem.joined(separator: ",")
                } else {
                    tmpValue = escaped("\(value)")
                }
                let queryItem = URLQueryItem(name: key, value: tmpValue)
                urlComponents.queryItems?.append(queryItem)
            }
            let queryString = urlComponents.query
            urlComponents.percentEncodedQuery = queryString
            urlRequest.url = urlComponents.url
        }

        urlRequest.setHeaders(headers: headers)
    }

    private func escaped(_ string: String) -> String {
        let escaped = string.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? string
        return escaped.replacingOccurrences(of: "+", with: "%2b")
    }
}
