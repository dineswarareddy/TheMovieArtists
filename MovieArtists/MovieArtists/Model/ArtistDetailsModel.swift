//
//  ArtistDetailsModel.swift
//  MovieArtists
//
//  Created by Dineswarareddy on 31/12/24.
//

import Foundation

class ArtistDetailsModel: Codable {
  internal init(name: String,
                id: Int,
                alsoKnownAs: [String]? = nil,
                biography: String? = nil,
                birthday: String? = nil,
                homepage: String? = nil,
                placeOfBirth: String? = nil,
                profilePath: String? = nil) {
    self.name = name
    self.id = id
    self.alsoKnownAs = alsoKnownAs
    self.biography = biography
    self.birthday = birthday
    self.homepage = homepage
    self.placeOfBirth = placeOfBirth
    self.profilePath = profilePath
  }
  
  var name: String
  var id: Int
  var alsoKnownAs: [String]?
  var biography: String?
  var birthday: String?
  var homepage: String?
  var placeOfBirth: String?
  var profilePath: String?
}
