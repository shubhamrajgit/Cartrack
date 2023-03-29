//
//  UserListTableCellVM.swift
//  CarTrack
//
//  Created by Shubham Raj on 28/03/23.
//

import Foundation

struct UserListCellVM {
    
    var name: String
    var username: String

    init(user: CTUser) {
        name = user.name
        username = "@" + "\(user.username)"
    }
}
