//
//  ArtistModel.swift
//  MovieArtists
//
//  Created by Dineswarareddy on 30/12/24.
//
class ArtistResults: Codable {
  let page: Int
  let results: [Artist]
  let totalPages: Int
  let totalResults: Int
}

class Artist: Codable {
  internal init(name: String,
                id: Int,
                originalName: String,
                profilePath: String?,
                knownForDepartment: String) {
    self.name = name
    self.id = id
    self.originalName = originalName
    self.profilePath = profilePath
    self.knownForDepartment = knownForDepartment
  }
  
  let name: String
  let id: Int
  let originalName: String?
  let profilePath: String?
  let knownForDepartment: String?
}
