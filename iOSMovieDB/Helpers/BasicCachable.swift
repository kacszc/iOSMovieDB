//
//  BasicCachable.swift
//  iOSMovieDB
//
//  Created by Kacper Szczepankiewicz on 03/12/2023.
//

import Foundation

protocol BasicCachable {
    func save<T: Encodable>(object: T, for key: String) throws
    func restore<T: Decodable>(for key: String) -> T?
}
