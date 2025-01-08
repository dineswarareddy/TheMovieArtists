//
//  NetworkResponse.swift
//  MovieArtists
//
//  Created by Dineswarareddy on 31/12/24.
//

import Foundation

struct NetworkResponse {
  
  var error: Error?
  var response: URLResponse?
  var data: Data?
  
  var httpStatusCode: Int {
    return ((response as? HTTPURLResponse)?.statusCode) ?? -1
  }
  
  var description: String {
    return "Response : HttpCode => \(self.httpStatusCode), Data => \(String(describing: data)), error => \(String(describing: error))"
  }
  
  func extractPayload() -> Json? {
    if let response = response as? HTTPURLResponse,
       (200...299).contains(response.statusCode) {
      return data?.deserialize() as? Json
    }
    return nil
  }
  
  func parseNetworkAPIResponse() -> (json: Any?, isSuccess: Bool, detailCode: Int?)? {
    
    if let json = data?.deserialize() as? Json {
      
      let result = json[httpResponseKeySuccess] as? Bool ?? false
      let errorCode = json[httpResponseKeyDetailCode] as? Int            
      
      return (json[httpResponseKeyData], result, errorCode)
    }
    
    return nil
  }
}

extension NetworkResponse {
  
  func extractStatus() -> (success: Bool, errorCode: Int?) {
    if let dictionary = self.extractPayload(),
       let success = dictionary["success"] as? Bool {
      let code = dictionary["detailCode"] as? Int
      return (success, success ? nil : code)
    }
    return (false, -1)
    
  }
}

