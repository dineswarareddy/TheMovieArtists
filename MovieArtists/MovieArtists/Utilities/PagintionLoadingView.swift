//
//  PagintionLoadingView.swift
//  MovieArtists
//
//  Created by Dineswarareddy on 31/12/24.
//

import SwiftUI

struct PaginationProgressView: View {
    var body: some View {
      HStack {
        Spacer()
        ProgressView()
//          .progressViewStyle(.circular)
//          .frame(width: 40, height: 40)
        Text("Loading Please wait")
          .frame(width: 200)
        Spacer()
      }
      .padding()
    }
}

#Preview {
    PaginationProgressView()
}
