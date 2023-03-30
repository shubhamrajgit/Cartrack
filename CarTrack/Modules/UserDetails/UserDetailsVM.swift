//
//  UserDetailsVM.swift
//  CarTrack
//
//  Created by Shubham Raj on 25/03/23.
//

import Foundation

struct UserDetailsVM {
    let userData: CTUser
}

extension UserDetailsVM {
    
    func getItemsCount() -> Int {
        return 3
    }
    
    var navigationTitle: String {
        return CTConstants.Details
    }
}
