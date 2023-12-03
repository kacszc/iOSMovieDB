//
//  NetworkError.swift
//  iOSMovieDB
//
//  Created by Kacper Szczepankiewicz on 03/12/2023.
//

import Foundation

enum NetworkError: Error {
    case decodingError
    case wrongStatusCode
}
