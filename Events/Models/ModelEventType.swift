//
//  ModelEventType.swift
//  Events
//
//  Created by Mohamed Helmy on 7/15/19.
//  Copyright © 2019 MohamedHelmy. All rights reserved.
//

import Foundation

struct ModelEventType: Codable {
    let name: String?
    let id: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case id = "id"
    }
}
