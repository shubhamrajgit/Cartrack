//
//  User.swift
//  CarTrack
//
//  Created by Shubham Raj on 25/03/23.
//

import Foundation

class User {
    //MARK: - Property
    var id: Int = 0
    var username: String?
    var password: String?
    
    //MARK: - Constructor
    init(_ id: Int, _ username: String, _ password: String) {
        self.id = id
        self.username = username
        self.password = password
    }
}

