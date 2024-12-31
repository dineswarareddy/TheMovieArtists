//
//  APIManager.swift
//  MovieArtists
//
//  Created by Dineswarareddy on 30/12/24.
//

import Foundation

protocol ArtistsListService {
  func fetchArtists(pageNumber: Int,
                    completion: @escaping (Result<Data, Error>) -> Void)
}

class ArtistsListServiceImpl: ArtistsListService {
  func fetchArtists(pageNumber: Int,
                    completion: @escaping (Result<Data, any Error>) -> Void) {
    let requestURL = URLConstructor(operationType:  .getPopularArtists(pageIndex: pageNumber)).getRequestURL()
    let request = NetworkRequest(endpointURL: requestURL,
                                 httpMethod: OperationType.getPopularArtists(pageIndex: pageNumber).httpMethod,
                                 data: nil)
    RestClient().send(request: request) { response, error in
      if let responseData = response?.data {
        completion(.success(responseData))
        return
      }
      completion(.failure(ArtistsListError.fetchArtistsListError))
    }
    
  }
}
