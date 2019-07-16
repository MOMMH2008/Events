//
//  NetworkSupport.swift
//  Events
//
//  Created by Mohamed Helmy on 7/15/19.
//  Copyright © 2019 MohamedHelmy. All rights reserved.
//

import Foundation

enum NetworkResponse {
    case success(Data)
    case failure(Error)
}

typealias Response<T: Codable> = (Result<T, Error>) -> Void

/// Name space for all http methods.
enum HTTPMethod: String {
    case get
    case post
    case put
}
