//
//  NetworkRequestHelperImpl.swift
//  MovieArtists
//
//  Created by Dineswarareddy on 31/12/24.
//

import UIKit

fileprivate let accept = "*/*;version=\("1.0")"
fileprivate let contentTypeApplicationJson = "application/json; charset=UTF-8"

protocol NetworkRequestHelper {
  func getCommonHeader() -> HttpHeaders
}
class NetworkRequestHelperImpl: NetworkRequestHelper {
  
  // Convenience function assuming all services will be using same header
  func getCommonHeader() -> HttpHeaders {
    var header = RequestHeaderBuilder()
      .with(accept: contentTypeApplicationJson)
      
    if let token = PlistManager().getToken() {
      header = header.with(authToken: "Bearer \(token)")
    }
    
    return header.get()
  }
}
