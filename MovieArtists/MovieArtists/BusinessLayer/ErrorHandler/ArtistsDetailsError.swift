//
//  ArtistsDetailsError.swift
//  MovieArtists
//
//  Created by Dineswarareddy on 31/12/24.
//

import Foundation

enum ArtistsDetailsError: Error {
  case fetchArtistsDetailsError
}

class ArtistsDetailsErrorHandler: AppErrorHandler {
  override func getErrorMessage(error: Error) -> Toast? {
    
    let errorFormat = super.getErrorMessage(error: error)
    if let _ = errorFormat {
      return errorFormat
    }
    
    guard let localError = error as? ArtistsDetailsError else { return nil }
    switch localError {
    case .fetchArtistsDetailsError:
      return Toast(style: .error,
                   message: FailureMessage.fetchArtistsDetailsError)
    }
  }
}
