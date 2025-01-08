//
//  RestClientError.swift
//  MovieArtists
//
//  Created by Dineswarareddy on 31/12/24.
//


import Foundation

enum RestClientError: Error, Equatable {
  
  case signInRequired
  case serverError
  case unsupportedAPIVersion
  case noInternetConnection
  case notAllowed
  
  init?(httpCode: Int) {
    
    switch httpCode {
    case 200...299:
      return nil
    case 401:
      self = .signInRequired
    case 405:
      self = .notAllowed
    case 410:
      self = .unsupportedAPIVersion
    case -1009:
      self = .noInternetConnection
    default:
      self = .serverError
    }
  }
}
