//
//  ArtistsListUsecase.swift
//  MovieArtists
//
//  Created by Dineswarareddy on 30/12/24.
//

import Foundation

protocol ArtistListUsecase {
  func fetchArtists(pageIndex: Int,
                    completion: @escaping ((Result<ArtistResults, ArtistsListError>) -> ()))
}

struct ArtistListUsecaseImpl: ArtistListUsecase {
  let repo: ArtistsListRepo
  init(repo: ArtistsListRepo = ArtistsListRepoImpl()) {
    self.repo = repo
  }
  
  func fetchArtists(pageIndex: Int,
                    completion: @escaping ((Result<ArtistResults, ArtistsListError>) -> ())) {
    repo.fetchArtists(page: pageIndex,
                      completion: completion)
  }
}
