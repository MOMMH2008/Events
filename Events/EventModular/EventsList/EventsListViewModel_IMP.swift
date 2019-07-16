//
//  EventsListViewModel_IMP.swift
//  Events
//
//  Created by Mohamed Helmy on 7/16/19.
//  Copyright © 2019 MohamedHelmy. All rights reserved.
//

import Foundation
class EventsListViewModelImp: EventsListViewModel {
    
    var events: [ModelEvent]
    var errorDescription: String?
    
    // flag of update
    var updatedModelEvent: Dynamic<Bool>
    
    // to init the VM
    init() {
        self.events = [ModelEvent]()
        self.errorDescription = ""
        self.updatedModelEvent = Dynamic(false)
    }
    
    func getEvents(eventType: String, page: String) {
        ModelEvent.getEventsRequest(eventType: eventType, page: page) { [unowned self] (result) in
            switch result {
            case .success(let events):
                self.events = events
                // very important for pind
                self.updatedModelEvent.value = true
            case .failure(let error):
                self.errorDescription = error.localizedDescription
                // very important for pind
                self.updatedModelEvent.value = false
            }
        }
    }
}
