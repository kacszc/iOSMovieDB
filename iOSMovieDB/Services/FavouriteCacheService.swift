//
//  FavouriteCacheService.swift
//  iOSMovieDB
//
//  Created by Kacper Szczepankiewicz on 03/12/2023.
//

import Foundation
import SwiftUI

protocol FavouriteCacheServiceProtocol {
    func save(id: Int)
    func remove(id: Int)
    func changeFor(id: Int, isFavourite: Bool)

    func restore() -> [Int]
}

class FavouriteCacheService: FavouriteCacheServiceProtocol {
    var cache = UserDefaultsCacheProvider()
    let key = UserDefaultsKeys.favouriteMovies.rawValue

    func save(id: Int) {
        var cacheData: [Int] = cache.restore(for: key) ?? [Int]()

        cacheData.append(id)
        
        try? cache.save(object: cacheData, for: key)
    }

    func remove(id: Int) {
        var cacheData: [Int] = cache.restore(for: key) ?? [Int]()

        cacheData.removeAll(where: { $0 == id })
        
        try? cache.save(object: cacheData, for: key)
    }

    func restore() -> [Int] {
        cache.restore(for: key) ?? [Int]()
    }

    func changeFor(id: Int, isFavourite: Bool) {
        if isFavourite {
            save(id: id)
        } else {
            remove(id: id)
        }
    }
    
}
