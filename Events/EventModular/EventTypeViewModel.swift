//
//  EventTypeViewModel.swift
//  Events
//
//  Created by Mohamed Helmy on 7/16/19.
//  Copyright © 2019 MohamedHelmy. All rights reserved.
//

import Foundation
protocol EventTypeViewModel {
    
    var eventType: [ModelEventType] { get }
    var errorDescription: String? { get }
    // the dynamic flag to fire the listener
    var updatedModelEventType: Dynamic <Bool> {get}
    var updatedModelEvent: Dynamic <Bool> {get}
    // ---------------Functions----------------
    func getEventType()
    func getEvents(eventType: String, page: String)
    
}

