//
//  Json.swift
//  MovieArtists
//
//  Created by Dineswarareddy on 31/12/24.
//

import Foundation

public typealias Json = [String: Any]

extension Json {
    
    func serialize() -> Data? {
        return try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
    }
}
