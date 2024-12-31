//
//  ArtistCardView.swift
//  MovieArtists
//
//  Created by Dineswarareddy on 31/12/24.
//

import SwiftUI

struct ArtistCardView: View {
  var artistToDisplay: Artist
  
  var body: some View {
    HStack(spacing: 20) {
      if let imagePath = artistToDisplay.profilePath {
        ImageView(urlString: ImageURLProvider().constructImageURL(path: imagePath))
          .frame(width: 100, height: 100)
      } else {
        RoundedRectangle(cornerRadius: 16)
          .frame(width: 100, height: 100)
          .foregroundStyle(Color(UIColor.lightGray))
          .clipShape(RoundedRectangle(cornerRadius: 16))
      }
      VStack(alignment: .leading) {
        Text(artistToDisplay.originalName ?? "")
          .foregroundStyle(Color.white)
        Text(artistToDisplay.knownForDepartment ?? "")
          .foregroundStyle(Color.white)
      }
      Spacer()
    }
    .background(Color.black)
    .clipShape(RoundedRectangle(cornerRadius: 16))
  }
}

#Preview {
  ArtistCardView(artistToDisplay: Artist(name: "test",
                                         id: 1,
                                         originalName: "aesf",
                                         profilePath: "open.jpg",
                                         knownForDepartment: "direction")
  )
}
