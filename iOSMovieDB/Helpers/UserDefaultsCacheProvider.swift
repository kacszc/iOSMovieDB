//
//  UserDefaultsCacheProvider.swift
//  iOSMovieDB
//
//  Created by Kacper Szczepankiewicz on 03/12/2023.
//

import Foundation

class UserDefaultsCacheProvider: BasicCachable {
    func save<T: Encodable>(object: T, for key: String) throws {
        let data = try JSONEncoder().encode(object)
        UserDefaults.standard.set(data, forKey: key)
    }
    
    func restore<T: Decodable>(for key: String) -> T? {
        guard let data = UserDefaults.standard.object(forKey: key) as? Data else {
            return nil
        }
        
        return try? JSONDecoder().decode(T.self, from: data)
    }
}
