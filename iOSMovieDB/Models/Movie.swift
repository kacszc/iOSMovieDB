//
//  Movie.swift
//  iOSMovieDB
//
//  Created by Kacper Szczepankiewicz on 02/12/2023.
//

import Foundation

class Movie: Decodable, Hashable {
    let id: Int
    let title: String
    let description: String
    let imagePath: String
    let releaseDate: String
    let voteAverage: Double

    var isFavourite: Bool = false

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description = "overview"
        case imagePath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: Movie, rhs: Movie) -> Bool {
        lhs.id == rhs.id
    }
}

extension Movie {
    var imageURL: URL? {
        URL(string: APIDetails.baseImageURL + imagePath)
    }
}

/*
 {
   "adult": false,
   "backdrop_path": "/9PqD3wSIjntyJDBzMNuxuKHwpUD.jpg",
   "genre_ids": [
     16,
     35,
     10751
   ],
   "id": 1075794,
   "original_language": "en",
   "original_title": "Leo",
   "overview": "Jaded 74-year-old lizard Leo has been stuck in the same Florida classroom for decades with his terrarium-mate turtle. When he learns he only has one year left to live, he plans to escape to experience life on the outside but instead gets caught up in the problems of his anxious students — including an impossibly mean substitute teacher.",
   "popularity": 1661.593,
   "poster_path": "/pD6sL4vntUOXHmuvJPPZAgvyfd9.jpg",
   "release_date": "2023-11-17",
   "title": "Leo",
   "video": false,
   "vote_average": 7.689,
   "vote_count": 318
 }
*/
