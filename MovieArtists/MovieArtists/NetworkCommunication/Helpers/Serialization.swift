
//
//  Serialization.swift
//  MovieArtists
//
//  Created by Dineswarareddy on 31/12/24.
//


import Foundation

let httpResponseKeyDetailCode = "detailCode"
let httpResponseKeyMessage = "message"
let httpResponseKeyData = "data"
let httpResponseKeySuccess = "success"

public typealias Serialization = [String: Any]

protocol SerializationKey {
    var stringValue: String { get }
}

extension RawRepresentable where RawValue == String {
    public var stringValue: String {
        return rawValue
    }
}

protocol SerializationValue {}

extension Bool: SerializationValue {}
extension String: SerializationValue {}
extension Int: SerializationValue {}
extension Int64: SerializationValue {}
extension Dictionary: SerializationValue {}
extension Array: SerializationValue {}
extension Float: SerializationValue {}

extension Dictionary where Key == String, Value: Any {
    func value<V: SerializationValue>(forKey key: SerializationKey) -> V? {
        return self[key.stringValue] as? V
    }
    
    func parseAsHttpResponse() -> (Any?, String?, ErrorCode?) {
        
        let message = self[httpResponseKeyMessage] as? String
        var errorCode : ErrorCode?
        if let error = self[httpResponseKeyDetailCode] as? Int {
            errorCode = ErrorCode(rawValue: error)
        }
        
        print("json => \(String(describing: self[httpResponseKeyData]))")
        print("message => \(String(describing: message))")
        print("error => \(String(describing: errorCode))")
        
        return (self[httpResponseKeyData], message, errorCode)
    }
}

