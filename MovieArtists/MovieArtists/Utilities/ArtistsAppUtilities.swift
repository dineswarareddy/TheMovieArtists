//
//  ArtistsAppUtilities.swift
//  MovieArtists
//
//  Created by Dineswarareddy on 31/12/24.
//

import Foundation
import UIKit
import SwiftUI

#if canImport(UIKit)
extension View {
  func hideKeyboard() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
  }
}
#endif
