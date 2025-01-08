//
//  Data+Extension.swift
//  MovieArtists
//
//  Created by Dineswarareddy on 31/12/24.
//

import Foundation
extension Data {
  public func deserialize() -> Any? {
    return try? JSONSerialization.jsonObject(with: self, options: .allowFragments)
  }
  
  mutating func append(_ string: String) {
      if let data = string.data(using: .utf8) {
          append(data)
      }
  }
}
