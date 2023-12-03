//
//  MovieListEndpoint.swift
//  iOSMovieDB
//
//  Created by Kacper Szczepankiewicz on 03/12/2023.
//

import Foundation

struct MovieListEndpoint: Endpoint {
    typealias Model = MovieListResponseDTO
    
    var path: String
    var headers: HTTPHeaders?
    var parametersEncoding: ParameterEncoding
    
    init(page: Int = 1) {
        self.path = "movie/now_playing"
        self.parametersEncoding = .urlEncoding(
            urlParameters: [
                "language":"en-US",
                "page":"\(page)"
            ]
        )
    }
}
