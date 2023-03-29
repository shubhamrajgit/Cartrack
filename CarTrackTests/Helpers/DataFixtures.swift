//
//  DataFixtures.swift
//  CarTrackTests
//
//  Created by Shubham Raj on 29/03/23.
//

import Foundation

class DataFixtures {
    
    static var userListData: Data { return jsonData("UserList_Success") }
    static var userListData_Failure: Data { return jsonData("UserList_failure") }

    private static func jsonData(_ filename: String) -> Data {
        let path = Bundle(for: self).path(forResource: filename, ofType: "json")!
        let jsonString = try! String(contentsOfFile: path, encoding: .utf8)
        return jsonString.data(using: .utf8)!
    }
}
