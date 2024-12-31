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
    ScrollView {
      VStack(alignment: .center,
             spacing: 20) {
        if let imageProfilePath = viewModel.artistDetails?.profilePath {
          ImageView(urlString: ImageURLProvider().constructImageURL(path: imageProfilePath))
            .frame(width: 200, height: 200)
        }
        nameView()
        birthDateView()
        birthPlaceView()
        websiteView()
      }
             .padding()
             .task {
               viewModel.fetchArtistDetails()
             }
    }
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
}

#Preview {
  ArtistDetailsView(viewModel: ArtistDetailsViewModel(artistId: 2))
}
