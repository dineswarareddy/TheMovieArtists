//
//  ArtistModel.swift
//  MovieArtists
//
//  Created by Dineswarareddy on 30/12/24.
//
class ArtistResults: Codable {
  let page: Int
  let results: [Artist]
  let total_page: Int
  let total_results: Int
}

class Artist: Codable {
  let name: String
  let id: Int
  let original_name: String
  let profile_path: String
}
