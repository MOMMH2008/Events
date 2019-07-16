//
//  EventTypeViewModel_IMP.swift
//  Events
//
//  Created by Mohamed Helmy on 7/16/19.
//  Copyright © 2019 MohamedHelmy. All rights reserved.
//

import Foundation
class EventTypeViewModelImp: EventTypeViewModel {
    
    var eventType: [ModelEventType]
    var events: [ModelEvent]
    var errorDescription: String?
    
    // flag of update
    var updatedModelEventType: Dynamic<Bool>
    var updatedModelEvent: Dynamic<Bool>
    
    // to init the VM
    init() {
        self.eventType = [ModelEventType]()
        self.events = [ModelEvent]()
        self.errorDescription = ""
        self.updatedModelEventType = Dynamic(false)
        self.updatedModelEvent = Dynamic(false)
    }
    
     func getEventType() {
        ModelEventType.getEventtypesRequest() { [unowned self] (result) in
            switch result {
            case .success(let eventType):
                self.eventType = eventType
                // very important for pind
                self.updatedModelEventType.value = true
            case .failure(let error):
                self.errorDescription = error.localizedDescription
                // very important for pind
                self.updatedModelEventType.value = false
            }
        }
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
