//
//  ArtistDetailsViewModel.swift
//  MovieArtists
//
//  Created by Dineswarareddy on 31/12/24.
//

import Foundation

class ArtistDetailsViewModel: ObservableObject {
  @Published var artistDetails: ArtistDetailsModel?
  var usecase: ArtistDetailsUsecase
  var artistId: Int
  
  init(usecase: ArtistDetailsUsecase = ArtistDetailsUsecaseImpl(),
       artistId: Int) {
    self.usecase = usecase
    self.artistId = artistId
  }
  
  func fetchArtistDetails() {
    usecase.fetchArtistsDetails(artistId: artistId) { response in
      DispatchQueue.main.async {
        switch response {
        case .success(let artistDetails):
          self.artistDetails = artistDetails
        case .failure(_):
          print("show error toast")
        }
      }
    }
  }
  
}
