//
//  ArtistMediaError.swift
//  MovieArtists
//
//  Created by Dineswarareddy on 31/12/24.
//

import Foundation

enum ArtistsMediaError: Error {
  case fetchArtistsMediaError
}

class ArtistsMediaErrorHandler: AppErrorHandler {
  override func getErrorMessage(error: Error) -> Toast? {
    
    let errorFormat = super.getErrorMessage(error: error)
    if let _ = errorFormat {
      return errorFormat
    }
    
    guard let localError = error as? ArtistsMediaError else { return nil }
    switch localError {
    case .fetchArtistsMediaError:
      return Toast(style: .error,
                   message: FailureMessage.fetchArtistImagesError)
    }
  }
}

