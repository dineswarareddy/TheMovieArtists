//
//  PlistManager.swift
//  MovieArtists
//
//  Created by Dineswarareddy on 30/12/24.
//

import Foundation

class PlistManager {
  func getToken() -> String? {
    if let path = Bundle.main.path(forResource: "Info", ofType: "plist"),
       let dict = NSDictionary(contentsOfFile: path) as? [String: AnyObject],
       let token = dict["AuthToken"] as? String {
      return token
    }
    return nil
  }
}
