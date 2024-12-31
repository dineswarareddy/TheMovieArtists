//
//  MediaModel.swift
//  MovieArtists
//
//  Created by Dineswarareddy on 31/12/24.
//

import Foundation

struct MediaModel: Codable {
  let id: Int
  let profiles: [Profile]?
}

struct Profile: Codable, Hashable {
  static func == (lhs: Profile, rhs: Profile) -> Bool {
    return lhs.filePath == rhs.filePath
  }
  
  let filePath: String?
}
