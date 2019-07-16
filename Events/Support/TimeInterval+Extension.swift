//
//  TimeInterval+Extension.swift
//  Events
//
//  Created by Mohamed Helmy on 7/16/19.
//  Copyright © 2019 MohamedHelmy. All rights reserved.
//

import Foundation
enum Cacheable {
    case yes(timeToLive: TimeToLive)
    case no
}

enum TimeToLive {
    
    // Hours
    case oneHour
    case twoHour
    
    // Days
    case oneDay
    case twoDays
    case threeDays
    
    // Weeks
    case oneWeek
    
    // Months
    case oneMonth
    // Year
    case year
    // custom
    case custom(TimeInterval)
    
    var time: TimeInterval {
        switch self {
        case .oneHour:
            return .oneHour
        case .twoHour:
            return .twoHour
        case .oneDay:
            return .oneDay
        case .twoDays:
            return .twoDays
        case .threeDays:
            return .threeDays
        case .oneWeek:
            return .oneWeek
        case .oneMonth:
            return .oneMonth
        case .year:
            return .year
        case .custom(let timeIn):
            return timeIn
        }
    }
}

extension TimeInterval {
    
    static var oneHour: TimeInterval {
        return 3600
    }
    static var twoHour: TimeInterval {
        return oneHour * 2
    }
    static var oneDay: TimeInterval {
        return 86400
    }
    static var twoDays: TimeInterval {
        return oneDay * 2
    }
    static var threeDays: TimeInterval {
        return oneDay * 3
    }
    static var oneWeek: TimeInterval {
        return oneDay * 7
    }
    static var oneMonth: TimeInterval {
        return oneDay * 30
    }
    static var year: TimeInterval {
        return oneDay * 365
    }
}
