//
//  DataCache.swift
//  Events
//
//  Created by Mohamed Helmy on 7/15/19.
//  Copyright © 2019 MohamedHelmy. All rights reserved.
//

import Foundation
import Cache

class DataCache {
    static let shared = DataCache()
    let diskConfig = DiskConfig(
        // The name of disk storage, this will be used as folder name within directory
        name: "Events",
        // Expiry date that will be applied by default for every added object
        // if it's not overridden in the `setObject(forKey:expiry:)` method
        expiry: .never,
        // Maximum size of the disk cache storage (in bytes)
        maxSize: 50000,
        // Where to store the disk cache. If nil, it is placed in `cachesDirectory` directory.
        directory: try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask,
                                                appropriateFor: nil, create: true).appendingPathComponent("EventsPreferences"),
        // Data protection is used to store files in an encrypted format on disk and to decrypt them on demand
        protectionType: .complete
    )
    private init() {}
    lazy var dataStorage = try! Storage (
        diskConfig: diskConfig,
        memoryConfig: MemoryConfig(),
        transformer: TransformerFactory.forData()
    )
    
}

extension DataCache {
    
    func setStringObject(_ value: String, key: String, _expiry: TimeInterval) {
        let stringStorge = dataStorage.transformCodable(ofType: String.self)
        try! stringStorge.setObject(value, forKey: key, expiry: .seconds(_expiry))
    }
    
    func getStringObject(key: String) -> String? {
        let stringStorge = dataStorage.transformCodable(ofType: String.self)
        return try? stringStorge.object(forKey: key)
    }
    
    func setDataObject(_ data: Data, key: String, _expiry: TimeInterval) {
        try! dataStorage.setObject(data, forKey: key, expiry: .seconds(_expiry))
    }
    
    func getDataObject(key: String) -> Data? {
        return try? dataStorage.object(forKey: key)
    }
    
    func setModelObject<T: Codable>(_ model: T, key: String) {
        let modelStorge = dataStorage.transformCodable(ofType: T.self)
        try! modelStorge.setObject(model, forKey: key)
    }
    func getModelObjct<T: Codable>(_ model: T, key: String) -> T? {
        let modelStorge = dataStorage.transformCodable(ofType: T.self)
        return try? modelStorge.object(forKey: key)
    }
}
