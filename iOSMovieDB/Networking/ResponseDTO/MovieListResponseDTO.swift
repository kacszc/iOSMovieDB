//
//  MovieListResponseDTO.swift
//  iOSMovieDB
//
//  Created by Kacper Szczepankiewicz on 03/12/2023.
//

import Foundation

struct MovieListResponseDTO: Decodable {
    let results: [Movie]
}
