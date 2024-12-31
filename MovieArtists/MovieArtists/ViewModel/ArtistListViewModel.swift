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
  @Published var searchText: String = ""
  private var previousSearchText: String = ""
 
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
  
  func getNextPageSearchContent() {
    currentIndex += 1
    searchArtists()
  }
  
  func resetSearchResultsAndIndex() {
    searchText = ""
    currentIndex = 0
    artists.removeAll()
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
    searchArtistsUsecase.searchArtists(query: searchText,
                                       pageIndex: currentIndex) { [weak self] response in
      DispatchQueue.main.async {
        self?.firstResponseReceived = true
        switch response {
        case .success(let artistResponse):
          if self?.previousSearchText != self?.searchText {
            self?.previousSearchText = self?.searchText ?? ""
            self?.artists = []
          }
          self?.artists.append(contentsOf: artistResponse.results)
          print(self?.artists)
        case .failure(let error):
          print("error received")
        }
      }
    }
  }
}
