//
//  ArtistsMediaUsecase.swift
//  MovieArtists
//
//  Created by Dineswarareddy on 31/12/24.
//

import Foundation

protocol ArtistMediaUsecase {
  func fetchArtistsMedia(artistId: Int,
                    completion: @escaping ((Result<MediaModel, ArtistsMediaError>) -> ()))
}

struct ArtistMediaUsecaseImpl: ArtistMediaUsecase {
  let repo: ArtistsMediaRepo
  init(repo: ArtistsMediaRepo = ArtistsMediaRepoImpl()) {
    self.repo = repo
  }
  
  func fetchArtistsMedia(artistId: Int,
                    completion: @escaping ((Result<MediaModel, ArtistsMediaError>) -> ())) {
    repo.fetchArtistsMedia(artistId: artistId,
                           completion: completion)
  }
}
