//
//  ArtistsDetailsManager.swift
//  MovieArtists
//
//  Created by Dineswarareddy on 31/12/24.
//

import Foundation

protocol ArtistsDetailsService {
  func fetchArtistsDetails(artistId: Int,
                           completion: @escaping (Result<Data, Error>) -> Void)
}

class ArtistsDetailsServiceImpl: ArtistsDetailsService {
  func fetchArtistsDetails(artistId: Int,
                           completion: @escaping (Result<Data, Error>) -> Void) {
    let requestURL = URLConstructor(operationType:  .getArtistsDetails(personId: artistId)).getRequestURL()
    let request = NetworkRequest(endpointURL: requestURL,
                                 httpMethod: OperationType.getArtistsDetails(personId: artistId).httpMethod,
                                 data: nil)
    RestClient().send(request: request) { response, error in
      if let responseData = response?.data {
        completion(.success(responseData))
        return
      }
      completion(.failure(ArtistsDetailsError.fetchArtistsDetailsError))
    }
  }
}
