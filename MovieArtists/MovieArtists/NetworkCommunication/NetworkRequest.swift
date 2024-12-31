//
//  NetworkRequest.swift
//  MovieArtists
//
//  Created by Dineswarareddy on 31/12/24.
//

import Foundation

typealias HttpHeaders = [String: String]

public enum HTTPMethod: String {
  
  case get = "GET"
  case put = "PUT"
  case post = "POST"
  case patch = "PATCH"
  case delete = "DELETE"
}

enum MimeType: String {
  
  case json = "application/json"
  case image = "image/jpg"
}

struct NetworkRequest {
  
  var endpointURL: String!
  var data: Data?
  var httpMethod: HTTPMethod!
  var headers: HttpHeaders?
  var timeout: TimeInterval
  var cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData
  static let timeoutInterval = TimeInterval(180)
  
  init(endpointURL: String,
       httpMethod: HTTPMethod,
       headers: HttpHeaders = NetworkRequestHelperImpl().getCommonHeader(),
       data: Data?,
       timeout: TimeInterval = timeoutInterval,
       cachePolicy: URLRequest.CachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData) {
    
    self.endpointURL = endpointURL
    self.httpMethod = httpMethod
    self.headers = headers
    self.timeout = timeout
    self.data = data
    self.cachePolicy = cachePolicy
  }
  
  mutating func updateHeaders() {
    self.headers = NetworkRequestHelperImpl().getCommonHeader()
  }
  
  func get() -> URLRequest? {
    guard let url = URL(string: endpointURL) else {
      print("Failed to construct url from path \(String(describing: endpointURL))")
      return nil
    }
    
    var request = URLRequest(url: url,
                             cachePolicy: cachePolicy,
                             timeoutInterval: timeout)
    request.httpMethod = httpMethod?.stringValue
    request.allHTTPHeaderFields = headers
    request.httpBody = data
    
    return request
  }
}
