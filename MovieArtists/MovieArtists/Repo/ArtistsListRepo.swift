//
//  ArtistsListRepo.swift
//  MovieArtists
//
//  Created by Dineswarareddy on 30/12/24.
//

import Foundation

protocol ArtistsListRepo {
  func fetchArtists(page: Int, completion: @escaping (Result<ArtistResults, Error>) -> Void)
}

class ArtistsRepoImpl: ArtistsListRepo {
  let service: ArtistsListService
  init(service: ArtistsListService = ArtistsListServiceImpl()) {
    self.service = service
  }
  
  func fetchArtists(page: Int,
                    completion: @escaping (Result<ArtistResults, any Error>) -> Void) {
      
  }
}
