//
//  Router.swift
//  Events
//
//  Created by Mohamed Helmy on 7/15/19.
//  Copyright © 2019 MohamedHelmy. All rights reserved.
//

import Foundation

enum RouterEvents: Endpoint{
    
    case getEventtypes
    case getEvents(eventType: String, page: String)
    
    // services URL
    var serviceUrl: String {
        switch self {
        case .getEventtypes:
            return "eventtypes"
        case .getEvents(let eventType, let page):
            return "events?event_type=\(eventType)&page=\(page)"
        }
    }
    
    // parameters
    var parameters: [String: Any]? {
        switch self {
        case .getEventtypes:
            return nil
        case .getEvents:
            return nil
        }
    }
    
    var isCacheable: Cacheable {
        switch self {
        case .getEventtypes:
            return .yes(timeToLive: .oneWeek)
        case .getEvents:
            return .yes(timeToLive: .oneHour)
        }
    }
    
    var cacheIdentifier: String {
        return serviceUrl
    }
    
}
