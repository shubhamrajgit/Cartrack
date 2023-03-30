//
//  APIEndpoints.swift
//  CarTrack
//
//  Created by Shubham Raj on 27/03/23.
//

import Foundation

private enum CTEnvironment {
    case staging
    case production
    
    func baseUrl() -> String {
        return "\(urlProtocol())://\(domain())"
    }
    
    func urlProtocol() -> String {
        return "https"
    }
    
    func domain() -> String {
        return "jsonplaceholder.typicode.com"
    }
}

struct CTAPIEndpoints {
    private let baseUrl = CTEnvironment.staging.baseUrl()
    var users: String { return "\(baseUrl)/users" }
}
