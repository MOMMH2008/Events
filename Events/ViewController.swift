//
//  ViewController.swift
//  Events
//
//  Created by Mohamed Helmy on 7/14/19.
//  Copyright © 2019 MohamedHelmy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      
    }

     func getEventtypes(completion: @escaping Response<[ModelEventType]>) {
        RouterEvents.getEventtypes.request(completion: completion)
    }
    
    func getEvents(completion: @escaping Response<[ModelEvent]>) {
        RouterEvents.getEvents(eventType: "Sports", page: "1").request(completion: completion)
    }
    
    @IBAction func dsf(_ sender: Any) {
        
//        getEventtypes { (result) in
//            switch result {
//            case .success(let eventType):
//                print("🥰" + (eventType[0].id ?? ""))
//                print("🤓" + (eventType[0].name ?? ""))
//
//            case .failure(let error):
//                print("😡" + error.localizedDescription)
//            }
//        }
        
        getEvents { (result) in
            switch result {
            case .success(let event):
                print("🥰" + (event[0].name ?? ""))
                print("🤓" + (event[0].endDate ?? ""))
                
            case .failure(let error):
                print("😡" + error.localizedDescription)
            }
        }
    }
    
}

