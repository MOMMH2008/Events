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
    var errorDescription: String?
    
    // flag of update
    var updatedModelEventType: Dynamic<Bool>
    
    // to init the VM
    init() {
        self.eventType = [ModelEventType]()
        self.errorDescription = ""
        self.updatedModelEventType = Dynamic(false)
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
}
