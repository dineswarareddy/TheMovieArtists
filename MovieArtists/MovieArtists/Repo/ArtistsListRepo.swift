//
//  ArtistsListRepo.swift
//  MovieArtists
//
//  Created by Dineswarareddy on 30/12/24.
//

import Foundation

protocol ArtistsListRepo {
  func fetchArtists(page: Int,
                    completion: @escaping (Result<ArtistResults, ArtistsListError>) -> Void)
}

class ArtistsListRepoImpl: ArtistsListRepo {
  let service: ArtistsListService
  init(service: ArtistsListService = ArtistsListServiceImpl()) {
    self.service = service
  }
  
  func fetchArtists(page: Int,
                    completion: @escaping (Result<ArtistResults, ArtistsListError>) -> Void) {
    service.fetchArtists(pageNumber: page) { result in
      switch result {
      case .success(let responseData):
        do {
          let artits: ArtistResults = try JsonParser.fetchModelFromData(responseData)
          completion(.success(artits))
        } catch(let error) {
          print(error)
          completion(.failure(.fetchArtistsListError))
        }
      case .failure(_):
        completion(.failure(.fetchArtistsListError))
      }
    }
  }
}
