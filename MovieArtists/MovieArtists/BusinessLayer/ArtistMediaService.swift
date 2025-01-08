//
//  ArtistMediaService.swift
//  MovieArtists
//
//  Created by Dineswarareddy on 31/12/24.
//

import Foundation


protocol ArtistMediaService {
  func fetchArtistMedia(artistId: Int,
                        completion: @escaping (Result<Data, Error>) -> Void)
}

class ArtistMediaServiceImpl: ArtistMediaService {
  func fetchArtistMedia(artistId: Int,
                        completion: @escaping (Result<Data, Error>) -> Void) {
    let requestURL = URLConstructor(operationType:  .getArtistMedia(personId: artistId)).getRequestURL()
    let request = NetworkRequest(endpointURL: requestURL,
                                 httpMethod: OperationType.getArtistMedia(personId: artistId).httpMethod,
                                 data: nil)
    RestClient().send(request: request) { response, error in
      if let responseData = response?.data {
        completion(.success(responseData))
        return
      }
      completion(.failure(ArtistsMediaError.fetchArtistsMediaError))
    }
  }
}
