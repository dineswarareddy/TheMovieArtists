//
//  ContentView.swift
//  MovieArtists
//
//  Created by Dineswarareddy on 30/12/24.
//

import SwiftUI

struct ArtistsListView: View {
  @StateObject var viewModel: ArtistListViewModel
  @StateObject var debounceObject = DebounceObject()
  
  var body: some View {
    NavigationView {
      VStack(spacing: 10) {
        searchBarView()
        artistsListView()
        .task {
          viewModel.fetchArtists()
        }
      }
    }
    .navigationTitle("Artists")
    .navigationBarTitleDisplayMode(.inline)
  }
  
  private func artistsListView() -> AnyView {
    AnyView(List {
      ForEach(viewModel.artists, id: \.id) { artist in
        NavigationLink(destination: ArtistDetailsView(viewModel: ArtistDetailsViewModel(artistId: artist.id))) {
          ArtistCardView(artistToDisplay: artist)
            .listRowSeparator(Visibility.hidden)
        }
      }
      .listStyle(.automatic)
      if viewModel.firstResponseReceived {
        PaginationProgressView()
          .onAppear() {
            invokeFetchArtistsListAPI()
          }
      }
    }
      .background(Color.black)
      .clipped()
      .padding(0)
    )
  }
  
  private func searchBarView() -> AnyView {
    AnyView(VStack {
      Text("Type name to search")
        .font(Font.system(size: 18))
      HStack {
        TextField("enter here", text: $debounceObject.text)
          .font(Font.system(size: 18))
          .onChange(of: debounceObject.debouncedText, perform: {text in
            // invoking search opeartion
            viewModel.searchText = text
            viewModel.searchArtists()
          })
        ZStack{
          Circle()
            .frame(width: 30, height: 30)
            .foregroundStyle(Color(UIColor.blue))
          Image(.cross)
            .resizable()
            .frame(width: 20, height: 20)
        }
        .onTapGesture {
          resetSerach()
        }
      }
      .padding()
      .frame(height: 40)
      .overlay(
        RoundedRectangle(cornerRadius: 20)
          .stroke(Color(UIColor.blue), lineWidth: 1)
      )
      .padding()
    })
  }
  
  private func invokeFetchArtistsListAPI() {
    if !viewModel.searchText.isEmpty {
      viewModel.getNextPageSearchContent()
    } else {
      viewModel.getNextPageContent()
    }
  }
  
  private func resetSerach() {
    debounceObject.text = ""
    viewModel.resetSearchResultsAndIndex()
    invokeFetchArtistsListAPI()
    hideKeyboard()
  }
}

#Preview {
  ArtistsListView(viewModel: ArtistListViewModel())
}
