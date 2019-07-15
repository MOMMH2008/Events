//
//  EventsApi.swift
//  Events
//
//  Created by Mohamed Helmy on 7/15/19.
//  Copyright © 2019 MohamedHelmy. All rights reserved.
//

import Foundation

class EventsApi {
    
    static func request<T: Decodable>(url: String,
                                      headers: [String: String]? = nil,
                                      httpMethod: HTTPMethod,
                                      parameters: [String: Any]? = nil,
                                      isPrintable: Bool,
                                      isCacheable: Cacheable,
                                      identifier: String,
                                      completion: @escaping Response<T>) {
        
        switch isCacheable {
        case .yes(let timetoLive):
            let expiry = timetoLive.time
            if let dataJson = DataCache.shared.getDataObject(key: identifier) {
                self.offlineRequest(url, data: dataJson, identifier: identifier, expiry: 0.0, completion: completion)
            } else {
                self.networkRequest(url: url,
                               headers: headers,
                               httpMethod: httpMethod,
                               parameters: parameters,
                               isPrintable: isPrintable,
                               expiry: expiry,
                               identifier: identifier,
                               completion: completion)
            }
        case .no:
            self.networkRequest(url: url,
                           headers: headers,
                           httpMethod: httpMethod,
                           parameters: parameters,
                           isPrintable: isPrintable,
                           expiry: 0.0,
                           identifier: identifier,
                           completion: completion)
        }
    }
    
    /// Get Data from offline cash
    static func offlineRequest<T: Decodable>(_ url: String,
                                            data: Data,
                                            identifier: String,
                                            expiry: TimeInterval,
                                            completion: @escaping Response<T>) {
        
            do {
                let decoder = JSONDecoder()
                /// add cache
                if expiry != 0.0 {
                    DataCache.shared.setDataObject(data, key: identifier, _expiry: expiry)
                }
                let data = try decoder.decode(T.self, from: data)
                completion(.success(data))
            } catch let error {
                // return decoding failed
                completion(.failure(error))
                PrintHelper.logNetwork("❌ Error in Mapping\n\(url)\nError:\n\(error)")
            }
        
    }
    
    /// Get Data from online Server
    static func networkRequest<T: Decodable>(url: String,
                                        headers: [String: String]? = nil,
                                        httpMethod: HTTPMethod,
                                        parameters: [String: Any]? = nil,
                                        isPrintable: Bool,
                                        expiry: TimeInterval,
                                        identifier: String,
                                        completion: @escaping Response<T>) {
        
        NetworkService.request(url: url, headers: headers, httpMethod: httpMethod, parameters: parameters, isPrintable: isPrintable) { (result) in
            switch result {
            case .success(let data):
                self.offlineRequest(url, data: data, identifier: identifier, expiry: expiry, completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
