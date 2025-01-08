//
//  ArtistsListError.swift
//  MovieArtists
//
//  Created by Dineswarareddy on 31/12/24.
//

import Foundation

enum ArtistsListError: Error {
  case fetchArtistsListError
}

class ArtistsListErrorHandler: AppErrorHandler {
  override func getErrorMessage(error: Error) -> Toast? {
    
    let errorFormat = super.getErrorMessage(error: error)
    if let _ = errorFormat {
      return errorFormat
    }
    
    guard let localError = error as? ArtistsListError else { return nil }
    switch localError {
    case .fetchArtistsListError:
      return Toast(style: .error,
                   message: FailureMessage.fetchArtistsListError)
    }
  }
}
