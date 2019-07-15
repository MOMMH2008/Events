//
//  Endpoint.swift
//  Events
//
//  Created by Mohamed Helmy on 7/15/19.
//  Copyright © 2019 MohamedHelmy. All rights reserved.
//

import Foundation

/// Server endpoint interface, any server router should implement this interface to be able to connect
protocol Endpoint {
    
    /// The last path component to the endpoint. will be appended to the base url in the service
    var serviceUrl: String { get }
    
    /// The encoded parameters
    var parameters: [String: Any]? { get }
    
    /// The HTTP headers to be appended in the request, default is nil
    var headers: [String: String]? { get }
    
    /// Http method as specified by the server
    var method: HTTPMethod { get }
    
    /// Determind if you want to print the response in the consol or not
    var isPrintable: Bool { get }
    
    /// Determind if you want to cashe the response or not
    var isCacheable: Cacheable { get }
    
    /// Identifier for cache
    var cacheIdentifier: String { get }
    
}
extension Endpoint {
    
    /// Base url with serviceUrl
    var url: String {
        return "http://private-7466b-eventtuschanllengeapis.apiary-mock.com/" + serviceUrl
    }
    
    var headers: [String: String]? {
        return nil
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var isPrintable: Bool {
        return true
    }
    
    var isCacheable: Cacheable {
        return .no
    }
    var cacheIdentifier: String {
        return ""
    }
    
    func request<T: Codable>(completion: @escaping Response<T>) {
        EventsApi.request(url: url,
                          headers: headers,
                          httpMethod: method,
                          parameters: parameters,
                          isPrintable: isPrintable,
                          isCacheable: isCacheable,
                          identifier: cacheIdentifier,
                          completion: completion)
    }
}
