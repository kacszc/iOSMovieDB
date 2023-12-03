//
//  ParameterEncoder.swift
//  iOSMovieDB
//
//  Created by Kacper Szczepankiewicz on 03/12/2023.
//

import Foundation

public typealias RequestParameters = [String: Any]

public protocol ParameterEncoder {
    var parameters: RequestParameters { get }
    var headers: HTTPHeaders { get }
    func encode(urlRequest: inout URLRequest) throws
}
