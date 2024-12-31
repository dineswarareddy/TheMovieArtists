//
//  ArtistDetailsView.swift
//  MovieArtists
//
//  Created by Dineswarareddy on 31/12/24.
//

import SwiftUI

struct ArtistDetailsView: View {
  @StateObject var viewModel: ArtistDetailsViewModel
  
  var body: some View {
    NavigationView{
      ScrollView {
        VStack(alignment: .center,
               spacing: 20) {
          if let imageProfilePath = viewModel.artistDetails?.profilePath {
            ImageView(urlString: ImageURLProvider().constructImageURL(path: imageProfilePath))
              .frame(width: 200, height: 200)
          } else {
            RoundedRectangle(cornerRadius: 16)
              .frame(width: 200, height: 200)
              .background(Color(UIColor.lightGray))
              .clipShape(RoundedRectangle(cornerRadius: 16))
          }
          nameView()
          birthDateView()
          birthPlaceView()
          websiteView()
          if !viewModel.artistMedia.isEmpty {
            mediaView()
          }
        }
               .padding()
               .task {
                 viewModel.fetchArtistDetails()
                 viewModel.fetchArtistMedia()
               }
      }
    }
    .navigationTitle("Artist Details")
  }
  
  func nameView() -> AnyView {
    AnyView(
      HStack(alignment: .top, spacing: 16) {
        Text("Name: ")
        Text(viewModel.artistDetails?.name ?? "")
        Spacer()
      }
    )
  }
  
  func birthDateView() -> AnyView {
    AnyView(
      HStack(alignment: .top, spacing: 16) {
        Text("Biography: ")
        Text(viewModel.artistDetails?.biography ?? "")
        Spacer()
      }
    )
  }
  
  func birthPlaceView() -> AnyView {
    AnyView(
      HStack(alignment: .top, spacing: 16) {
        Text("Place Of Birth: ")
        Text(viewModel.artistDetails?.placeOfBirth ?? "")
        Spacer()
      }
    )
  }
  
  func websiteView() -> AnyView {
    AnyView(
      HStack(alignment: .top, spacing: 16) {
        Text("Website: ")
        Text(viewModel.artistDetails?.homepage ?? "")
        Spacer()
      }
    )
  }
  
  func mediaView() -> AnyView {
    AnyView(
      VStack(alignment: .leading,
             spacing: 16) {
               Text("Gallery")
                 .fontWeight(.bold)
               let rows = [
                GridItem(.flexible()),
               ]
               ScrollView(.horizontal) {
                 LazyHGrid(rows: rows, spacing: 10) {
                   ForEach(viewModel.artistMedia, id: \.self) { item in
                     if let imageProfilePath = item.filePath {
                       ImageView(urlString: ImageURLProvider().constructImageURL(path: imageProfilePath))
                         .frame(width: 200, height: 200)
                     }
                   }
                   .frame(height: 200)
                 }
               }
             }
    )
  }
}

#Preview {
  ArtistDetailsView(viewModel: ArtistDetailsViewModel(artistId: 2))
}
