//
//  EventsListViewModel.swift
//  Events
//
//  Created by Mohamed Helmy on 7/16/19.
//  Copyright © 2019 MohamedHelmy. All rights reserved.
//

import Foundation
protocol EventsListViewModel {
    var events: [ModelEvent] { get }
    var errorDescription: String? { get }
    // the dynamic flag to fire the listener
    var updatedModelEvent: Dynamic <Bool> {get}
    // ---------------Functions----------------
    func getEvents(eventType: String, page: String)
    
}
