//
//  ArtistDetailsRepo.swift
//  MovieArtists
//
//  Created by Dineswarareddy on 31/12/24.
//

import Foundation

protocol ArtistsDetailsRepo {
  func fetchArtistsDetails(artistId: Int,
                           completion: @escaping (Result<ArtistDetailsModel, ArtistsDetailsError>) -> Void)
}

class ArtistsDetailsRepoImpl: ArtistsDetailsRepo {
  let service: ArtistsDetailsService
  init(service: ArtistsDetailsService = ArtistsDetailsServiceImpl()) {
    self.service = service
  }
  
  func fetchArtistsDetails(artistId: Int,
                           completion: @escaping (Result<ArtistDetailsModel, ArtistsDetailsError>) -> Void) {
    
    service.fetchArtistsDetails(artistId: artistId) { response in
      switch response {
      case .success(let responseData):
        do {
          let artits: ArtistDetailsModel = try JsonParser.fetchModelFromData(responseData)
          completion(.success(artits))
        } catch(let error) {
          print(error)
          completion(.failure(.fetchArtistsDetailsError))
        }
      case .failure(_):
        completion(.failure(.fetchArtistsDetailsError))
      }
    }
  }
}
