//
//  ModelEvent.swift
//  Events
//
//  Created by Mohamed Helmy on 7/15/19.
//  Copyright © 2019 MohamedHelmy. All rights reserved.
//

import Foundation

struct ModelEvent: Codable {
    let longitude: String?
    let latitude: String?
    let endDate: String?
    let startDate: String?
    let cover: String?
    let name: String?
    let id: String?
    
    enum CodingKeys: String, CodingKey {
        case longitude = "longitude"
        case latitude = "latitude"
        case endDate = "end_date"
        case startDate = "start_date"
        case cover = "cover"
        case name = "name"
        case id = "id"
    }
}

extension ModelEvent {
    // For End Point
    static func getEventsRequest(eventType: String, page: String, completion: @escaping Response<[ModelEvent]>) {
        RouterEvents.getEvents(eventType: eventType, page: page).request(completion: completion)
    }
}
