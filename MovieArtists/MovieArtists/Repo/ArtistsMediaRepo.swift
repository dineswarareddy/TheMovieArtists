//
//  ArtistsMediaRepo.swift
//  MovieArtists
//
//  Created by Dineswarareddy on 31/12/24.
//

import Foundation

protocol ArtistsMediaRepo {
  func fetchArtistsMedia(artistId: Int, completion: @escaping (Result<MediaModel, ArtistsMediaError>) -> Void)
}

class ArtistsMediaRepoImpl: ArtistsMediaRepo {
  let service: ArtistMediaService
  init(service: ArtistMediaService = ArtistMediaServiceImpl()) {
    self.service = service
  }
  
  func fetchArtistsMedia(artistId: Int,
                         completion: @escaping (Result<MediaModel, ArtistsMediaError>) -> Void) {
    service.fetchArtistMedia(artistId: artistId) { result in
      switch result {
      case .success(let responseData):
        do {
          let artiseMedia: MediaModel = try JsonParser.fetchModelFromData(responseData)
          completion(.success(artiseMedia))
        } catch(let error) {
          print(error)
          completion(.failure(.fetchArtistsMediaError))
        }
      case .failure(_):
        completion(.failure(.fetchArtistsMediaError))
      }
    }
  }
}
