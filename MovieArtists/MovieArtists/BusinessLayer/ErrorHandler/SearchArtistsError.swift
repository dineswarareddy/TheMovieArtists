//
//  SearchArtistsError.swift
//  MovieArtists
//
//  Created by Dineswarareddy on 31/12/24.
//

import Foundation

enum SearchArtistsError: Error {
  case searchArtistsError
}

class SearchArtistsErrorHandler: AppErrorHandler {
  override func getErrorMessage(error: Error) -> Toast? {
    
    let errorFormat = super.getErrorMessage(error: error)
    if let _ = errorFormat {
      return errorFormat
    }
    
    guard let localError = error as? SearchArtistsError else { return nil }
    switch localError {
    case .searchArtistsError:
      return Toast(style: .error,
                   message: FailureMessage.searchArtistError)
    }
  }
}
