//
//  JSONarser.swift
//  MovieArtists
//
//  Created by Dineswarareddy on 31/12/24.
//

import Foundation

class JsonParser {
    static func fetchModelFromData<T: Decodable>(_ responseData: Data) throws -> T {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(T.self, from: responseData)
    }
}
