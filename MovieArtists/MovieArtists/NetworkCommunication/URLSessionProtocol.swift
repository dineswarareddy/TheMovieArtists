
import Foundation

protocol URLSessionDataTaskProtocol {
  func resume()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}

typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void

protocol URLSessionProtocol {
  
  func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol
  func invalidateAndCancel()
}

extension URLSession: URLSessionProtocol {
  
  func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
    let task: URLSessionDataTask = dataTask(with: request,
                                            completionHandler: completionHandler) as URLSessionDataTask
    return task
  }
}
