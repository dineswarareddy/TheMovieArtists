//
//  ArtistDetailsUsecase.swift
//  MovieArtists
//
//  Created by Dineswarareddy on 31/12/24.
//

import Foundation

protocol ArtistDetailsUsecase {
  func fetchArtistsDetails(artistId: Int,
                           completion: @escaping ((Result<ArtistDetailsModel, ArtistsDetailsError>) -> ()))
}

struct ArtistDetailsUsecaseImpl: ArtistDetailsUsecase {
  let repo: ArtistsDetailsRepo
  init(repo: ArtistsDetailsRepo = ArtistsDetailsRepoImpl()) {
    self.repo = repo
  }
  
  func fetchArtistsDetails(artistId: Int,
                           completion: @escaping ((Result<ArtistDetailsModel, ArtistsDetailsError>) -> ())) {
    repo.fetchArtistsDetails(artistId: artistId,
                             completion: completion)
  }
}
