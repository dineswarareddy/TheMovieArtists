//
//  ArtistsSearchManager.swift
//  MovieArtists
//
//  Created by Dineswarareddy on 31/12/24.
//

import Foundation

protocol ArtistsSearchService {
  func searchArtists(query: String,
                     pageIndex: Int,
                     completion: @escaping (Result<Data, Error>) -> Void)
}

class ArtistsSearchServiceImpl: ArtistsSearchService {
  func searchArtists(query: String,
                     pageIndex: Int,
                     completion: @escaping (Result<Data, Error>) -> Void) {
    let requestURL = URLConstructor(operationType: .searchArtists(query: query, pageIndex: pageIndex)).getRequestURL()
    let request = NetworkRequest(endpointURL: requestURL,
                                 httpMethod: OperationType.searchArtists(query: query,
                                                                         pageIndex: pageIndex).httpMethod,
                                 data: nil)
    RestClient().send(request: request) { response, error in
      if let responseData = response?.data {
        completion(.success(responseData))
        return
      }
      completion(.failure(SearchArtistsError.searchArtistsError))
    }
  }
}
