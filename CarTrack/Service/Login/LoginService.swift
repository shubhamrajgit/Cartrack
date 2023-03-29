//
//  LoginService.swift
//  CarTrack
//
//  Created by Shubham Raj on 25/03/23.
//

import Foundation

//MARK: - Protocols
protocol LoginServiceType {
    func login(username: String,
               password: String,
               completion: @escaping (Bool) -> ())
}

//MARK: - LoginService
class LoginService: LoginServiceType {
    
    //MARK: - Property
    private var db: UserSQLiteServiceType?
    
    init() {
        self.insertUsers()
    }
    
    private func initializeUserDB() {
        let userDB = UserSQLiteService(dbName: CTConstants.USER_DB)
        db = userDB
    }
    
    //MARK: - User Insertion
    //NOTE: - Manually Inserting th data because there is no registration page.
    private func insertUsers() {
        
        self.initializeUserDB()
        guard let userDB = self.db else {
            return
        }
        userDB.insert(id: 1,
                      username: "shubham",
                      password: "test123")
        
        userDB.insert(id: 2,
                      username: "shubham1",
                      password: "test123")
        
        userDB.insert(id: 3,
                      username: "shubham2",
                      password: "test123")
    }
    
    func login(username: String,
               password: String,
               completion: @escaping (Bool) -> ()) {
        
        if db == nil {
            self.initializeUserDB()
        }
        let result = db?.login(username: username,
                               password: password)
        completion(result ?? false)
    }
}
