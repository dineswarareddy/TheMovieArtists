//
//  ImageURLProvider.swift
//  MovieArtists
//
//  Created by Dineswarareddy on 31/12/24.
//

import Foundation

class ImageURLProvider {
  func constructImageURL(path: String) -> String {
    return "https://image.tmdb.org/t/p/w500/\(path)"
  }
}
