//
//  ErrorCode.swift
//  MovieArtists
//
//  Created by Dineswarareddy on 31/12/24.
//

//  URLConstructionHelper.swift

import Foundation

enum OperationType {
  case getPopularArtists(pageIndex: Int)
  case searchArtists(query: String,
                     pageIndex: Int)
  case getArtistsDetails(personId: Int)
  
  var httpMethod: HTTPMethod {
    switch self {
    case .getPopularArtists,
        .searchArtists,
        .getArtistsDetails:
      return .get
    }
  }
  
  // ****
  // For time being adding path params statically. Generally we have to pass those to Network Request creation class and append these to URL.
  var urlPath: String {
    switch self {
    case .getPopularArtists(let pageNumber):
      return "person/popular?language=en-US&page=\(pageNumber)"
    case .searchArtists(let searchText, let pageNumber):
      return "search/person?query=\(searchText)&language=en-US&page=\(pageNumber)"
    case .getArtistsDetails(let personId):
      return "person/\(personId)?language=en-US"
    }
  }
}

struct URLConstructor {
  var baseURL = "https://api.themoviedb.org/3/"
  let operationType: OperationType
  internal init(operationType: OperationType) {
    self.operationType = operationType
  }
  
  func getRequestURL() -> String {
    return (baseURL + operationType.urlPath)
  }
}
