//
//  NetworkProvider.swift
//  iOSMovieDB
//
//  Created by Kacper Szczepankiewicz on 03/12/2023.
//

import Foundation

protocol NetworkProvider {
    func executeRequest<T: Endpoint>(route: T) async throws -> T.Model
}

