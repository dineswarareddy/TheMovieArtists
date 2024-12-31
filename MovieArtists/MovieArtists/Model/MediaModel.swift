//
//  MediaModel.swift
//  MovieArtists
//
//  Created by Dineswarareddy on 31/12/24.
//

import Foundation

class MediaModel: Codable {
  let id: Int
  let profiles: [Profile]?
}

class Profile: Codable {
  let filePath: String?
}
