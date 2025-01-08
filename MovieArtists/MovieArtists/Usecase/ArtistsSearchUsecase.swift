//
//  ArtistsSearchUsecase.swift
//  MovieArtists
//
//  Created by Dineswarareddy on 31/12/24.
//

import Foundation

protocol ArtistSearchUsecase {
  func searchArtists(query: String,
                     pageIndex: Int,
                     completion: @escaping ((Result<ArtistResults, SearchArtistsError>) -> ()))
}

struct ArtistSearchUsecaseImpl: ArtistSearchUsecase {
  let repo: ArtistsSearchRepo
  init(repo: ArtistsSearchRepo = ArtistsSearchRepoImpl()) {
    self.repo = repo
  }
  
  func searchArtists(query: String,
                    pageIndex: Int,
                    completion: @escaping ((Result<ArtistResults, SearchArtistsError>) -> ())) {
    repo.searchArtists(query: query,
                       page: pageIndex,
                       completion: completion)
  }
}

