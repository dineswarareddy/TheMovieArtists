//
//  ArtistsSearchRepo.swift
//  MovieArtists
//
//  Created by Dineswarareddy on 30/12/24.
//

import Foundation

protocol ArtistsSearchRepo {
  func searchArtists(query: String,
                    page: Int,
                    completion: @escaping (Result<ArtistResults, SearchArtistsError>) -> Void)
}

class ArtistsSearchRepoImpl: ArtistsSearchRepo {
  let service: ArtistsSearchService
  init(service: ArtistsSearchService = ArtistsSearchServiceImpl()) {
    self.service = service
  }
  
  func searchArtists(query: String,
                    page: Int,
                    completion: @escaping (Result<ArtistResults, SearchArtistsError>) -> Void) {
    service.searchArtists(query: query,
                          pageIndex: page,
                          completion: { result in
      switch result {
      case .success(let responseData):
        do {
          let artits: ArtistResults = try JsonParser.fetchModelFromData(responseData)
          completion(.success(artits))
        } catch(let error) {
          print(error)
          completion(.failure(.searchArtistsError))
        }
      case .failure(_):
        completion(.failure(.searchArtistsError))
      }
    })
  }
}
