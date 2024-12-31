//
//  ArtistListViewModel.swift
//  MovieArtists
//
//  Created by Dineswarareddy on 30/12/24.
//

import Foundation
import SwiftUI

class ArtistListViewModel: ObservableObject {
  @Published var artists: [Artist] = []
  @Published var isLoading: Bool = false
  @Published var firstResponseReceived: Bool = false
  @Published var searchingKeyword = ""
  @Binding var searchText: String = ""
  
  var currentIndex = 1
  var usecase: ArtistListUsecase
  var searchArtistsUsecase: ArtistSearchUsecase
  
  init(usecase: ArtistListUsecase = ArtistListUsecaseImpl(),
       searchArtistsUsecase: ArtistSearchUsecase = ArtistSearchUsecaseImpl()) {
    self.usecase = usecase
    self.searchArtistsUsecase = searchArtistsUsecase
  }
  
  func getNextPageContent() {
    currentIndex += 1
    fetchArtists()
  }
  
  func fetchArtists() {
    usecase.fetchArtists(pageIndex: currentIndex) { [weak self] response in
      DispatchQueue.main.async {
        self?.firstResponseReceived = true
        switch response {
        case .success(let artistResponse):
          self?.artists.append(contentsOf: artistResponse.results)
          print(self?.artists)
        case .failure(let error):
          print("error received")
        }
      }
    }
  }
  
  func searchArtists() {
    searchArtistsUsecase.searchArtists(query: $searchText,
                                       pageIndex: currentIndex) { [weak self] response in
      DispatchQueue.main.async {
        self?.firstResponseReceived = true
        switch response {
        case .success(let artistResponse):
          self?.artists.append(contentsOf: artistResponse.results)
          print(self?.artists)
        case .failure(let error):
          print("error received")
        }
      }
    }
  }
}
