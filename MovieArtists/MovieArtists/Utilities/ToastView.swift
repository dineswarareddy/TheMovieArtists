//
//  ToastView.swift
//  MovieArtists
//
//  Created by Dineswarareddy on 31/12/24.
//

import SwiftUI

struct Toast: Equatable {
  var style: ToastStyle
  var message: String
  var duration: Double = 6
  var width: Double = .infinity
}

struct ToastView: View {
  var style: ToastStyle
  var message: String
  var width = CGFloat.infinity
  var onCancelTapped: (() -> Void)
  
  var body: some View {
    HStack(alignment: .center, spacing: 12) {
      Image(systemName: style.iconFileName)
        .foregroundColor(style.themeColor)
      Text(message)
//        .font(Font.caption)
//        .foregroundColor(Color.white)
//        .tint(Color.white)
      
      Spacer(minLength: 10)
      
//      Button {
//        onCancelTapped()
//      } label: {
//        Image(systemName: "xmark")
//          .foregroundColor(style.themeColor)
//      }
    }
    .padding()
    .frame(minWidth: 0, maxWidth: width)
//    .background(Color(UIColor.themeLightColor()))
    .background(.white)
    .cornerRadius(8)
    .overlay(
      RoundedRectangle(cornerRadius: 8)
        .opacity(0.6)
    )
    .padding(.horizontal, 16)
  }
}
