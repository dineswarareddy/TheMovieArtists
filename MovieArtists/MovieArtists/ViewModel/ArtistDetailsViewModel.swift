//
//  ArtistDetailsViewModel.swift
//  MovieArtists
//
//  Created by Dineswarareddy on 31/12/24.
//

import Foundation

class ArtistDetailsViewModel: ObservableObject {
  @Published var artistDetails: ArtistDetailsModel?
  @Published var artistMedia: [Profile] = []
  var usecase: ArtistDetailsUsecase
  var mediaUsecase: ArtistMediaUsecase
  var artistId: Int
  
  init(usecase: ArtistDetailsUsecase = ArtistDetailsUsecaseImpl(),
       mediauseCase: ArtistMediaUsecase = ArtistMediaUsecaseImpl(),
       artistId: Int) {
    self.usecase = usecase
    self.mediaUsecase = mediauseCase
    self.artistId = artistId
  }
  
  func fetchArtistDetails() {
    usecase.fetchArtistsDetails(artistId: artistId) { [weak self] response in
      DispatchQueue.main.async {
        switch response {
        case .success(let artistDetails):
          self?.artistDetails = artistDetails
        case .failure(_):
          print("show error toast")
        }
      }
    }
  }
  
  func fetchArtistMedia() {
    mediaUsecase.fetchArtistsMedia(artistId: artistId) { [weak self] response in
      DispatchQueue.main.async {
        switch response {
        case .success(let mediaModel):
          self?.artistMedia = mediaModel.profiles ?? []
        case .failure(_):
          print("fetchind media error")
        }
      }
    }
  }
}
