//
//  RestClient.swift
//  MovieArtists
//
//  Created by Dineswarareddy on 31/12/24.
//


import Foundation

class RestClient {
  
  var urlSession: URLSessionProtocol
  
  init(session: URLSessionProtocol = URLSession.shared) {
    self.urlSession = session
  }
  
  func send(request: NetworkRequest,
            completionCallback: @escaping (NetworkResponse?, RestClientError?) -> Void) {
    
    guard let urlRequest = request.get() else {
      let restClientError: RestClientError = .serverError
      return completionCallback(nil, restClientError)
    }
    
    self.printRequest(request: request)
    let requestString = urlRequest.url?.absoluteString ?? ""
    
    RestClient.logRequest(urlRequest)
    self.urlSession.dataTask(with: urlRequest) { (data, response, error) in
      RestClient.logResponse(response, data: data, error: error)
      
      self.printResponse(for: request, response: response, data: data, error: error)
      
      let networkResponse = NetworkResponse(error: error, response: response, data: data)
      let restclientError = self.createRestClientError(networkResponse: networkResponse)
      print(networkResponse.description)
      return completionCallback(networkResponse, restclientError)
      
    }.resume()
  }
  
  func cancel() {
    self.urlSession.invalidateAndCancel()
  }
}

extension RestClient {
  
  func createRestClientError(networkResponse: NetworkResponse) -> RestClientError? {
    
    guard let restClientError = RestClientError(httpCode: networkResponse.httpStatusCode) else {
      guard let error = networkResponse.error, let errorFromResponse = RestClientError(httpCode: (error as NSError).code) else {
        return nil
      }
      return errorFromResponse
    }
    return restClientError
  }
}

extension RestClient {
  
  func printRequest(request: NetworkRequest) {
    print("\(String(describing: request.httpMethod)) => \(String(describing: request.endpointURL)) ==> \(String(describing: request.data?.deserialize() as? [String: Any]))")
  }
  
  func printResponse(for request: NetworkRequest, response: URLResponse?, data: Data?, error: Error?) {
    if let responseData = data{
      let responseString = String(data: responseData, encoding: .utf8) ?? ""
      print("\(String(describing: request.httpMethod)) <= \(String(describing: request.endpointURL))\n: Response: \(String(describing: response)),\n Data: \(responseString),\n Error: \(String(describing: error)) ")
    } else {
      print("\(String(describing: request.httpMethod)) <= \(String(describing: request.endpointURL))\n: Response: \(String(describing: response)),\n \'DATA is NIL\',\n Error: \(String(describing: error)) ")
    }
    
    print("-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_")
  }
}

//MARK: file logs
extension RestClient {
  static func logMessage(_ message: String) {
    print(message)
  }
  
  static func logRequest(_ request: URLRequest, hideBody: Bool = false) {
    var logReqMessage = "Request URL: \(request.url?.absoluteString ?? "NA")"
    logReqMessage += "\n" + "- Method: \(request.httpMethod ?? "Undefined")"
    logReqMessage += "\n" + "- Headers: \(request.allHTTPHeaderFields ?? [:])"
    if !hideBody {
      if let dataResponse = request.httpBody {
        let responseJSON = String(decoding: dataResponse, as: UTF8.self)
        logReqMessage += "\n" + "- Body: \(responseJSON)"
      } else {
        logReqMessage += "\n" + "- Body: No Data - IsHideen : \(hideBody)"
      }
    }
    RestClient.logMessage(logReqMessage)
  }
  
  static func logResponse(_ response: URLResponse?,
                          data: Data?,
                          error: Error?,
                          hideBody: Bool = false) {
    var logResMessage = "Response of URL: \(response?.url?.absoluteString ?? "NA")"
    let statusCode = (response as? HTTPURLResponse)?.statusCode
    logResMessage += "\n" + "- Code: \(statusCode ?? 0)"
    
    if !hideBody, let dataResponse = data {
      let responseJSON = String(decoding: dataResponse, as: UTF8.self)
      logResMessage += "\n" + "- Body: \(responseJSON)"
    }
    else {
      logResMessage += "\n" + "- Body: No data - IsHideen : \(hideBody)"
    }
    RestClient.logMessage(logResMessage)
    if error != nil {
      RestClient.logMessage("- Error: \(error.debugDescription)")
    }
  }
}
