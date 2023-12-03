//
//  URLRequest+Headers.swift
//  iOSMovieDB
//
//  Created by Kacper Szczepankiewicz on 03/12/2023.
//

import Foundation

extension URLRequest {
    mutating func addHeaders(headers: HTTPHeaders) {
        for header in headers {
            addValue(header.value, forHTTPHeaderField: header.key)
        }
    }

    mutating func setHeaders(headers: HTTPHeaders) {
        for header in headers {
            setValue(header.value, forHTTPHeaderField: header.key)
        }
    }
}

extension URLRequest {
    mutating func encode(with encoding: ParameterEncoding) {
        encoding.encode(urlRequest: &self)
    }
}
