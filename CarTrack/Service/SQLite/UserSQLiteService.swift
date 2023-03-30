//
//  UserSQLiteService.swift
//  CarTrack
//
//  Created by Shubham Raj on 27/03/23.
//

import Foundation
import SQLite3

protocol UserSQLiteServiceType {
    
    func login(username: String,
               password: String) -> Bool
    
    func insert(id: Int,
                username: String,
                password: String)
}

class UserSQLiteService: SQLiteService {
    
    var db: OpaquePointer?
    
    init(dbName: String) {
        super.init()
        
        self.db = openDatabase(dbPath: dbName)
        self.createUserTable()
    }
    
    //MARK: - Create User Table
    private func createUserTable() {
        
        let createTableString = """
                                CREATE TABLE IF NOT EXISTS User (
                                Id INTEGER PRIMARY KEY,
                                Username TEXT,
                                Password TEXT);
                                """
        
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db,
                              createTableString,
                              -1,
                              &createTableStatement,
                              nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                debugPrint("User table created.")
            } else {
                debugPrint("User table could not be created.")
            }
        } else {
            debugPrint("CREATE USER TABLE statement could not be prepared.")
        }
        
        sqlite3_finalize(createTableStatement)
    }
    
    //MARK: - INSERT User Data
    
    ///Used for inserting the data into
    ///- Parameters:
    ///   - Id: Int
    ///   - username: String
    ///   - password: String
    func insertUserData(id: Int,
                        username: String,
                        password: String) -> Bool {
        
        guard !checkUsernameAlreadyExists(username: username) else {
            debugPrint("Can not insert data as username already exists.")
            return false
        }
        
        let insertStatementString = """
                                    INSERT INTO User (
                                    Id, Username, Password)
                                    VALUES (?, ?, ?);
                                    """
        
        var insertionResult = false
        var insertStatement: OpaquePointer? = nil
        
        
        if sqlite3_prepare_v2(db,
                              insertStatementString,
                              -1,
                              &insertStatement,
                              nil) == SQLITE_OK {
            
            sqlite3_bind_int(insertStatement,
                             1,
                             Int32(id))
            
            sqlite3_bind_text(insertStatement,
                              2,
                              (username as NSString).utf8String,
                              -1,
                              nil)
            
            sqlite3_bind_text(insertStatement,
                              3,
                              (password as NSString).utf8String,
                              -1,
                              nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                insertionResult = true
                debugPrint("Successfully inserted row.")
            } else {
                debugPrint("Could not insert row.")
            }
        } else {
            debugPrint("INSERT query could not be prepared.")
        }
        
        sqlite3_finalize(insertStatement)
        return insertionResult
    }
    
    //MARK: - Check Username
    
    ///Used for checking if username already exists
    ///- Parameters:
    ///   - username: String
    func checkUsernameAlreadyExists(username: String) -> Bool {
        
        let usernameStatementString = """
                                    SELECT * FROM User
                                    WHERE Username='\(username)';
                                    """
        
        var userExists = false
        var usernameStatement: OpaquePointer?
        
        if sqlite3_prepare_v2(db,
                              usernameStatementString,
                              -1,
                              &usernameStatement,
                              nil) == SQLITE_OK {
            
            if sqlite3_step(usernameStatement) == SQLITE_ROW {
                userExists = true
            }
        } else {
            debugPrint("SELECT query could not be prepared.")
        }
        
        sqlite3_finalize(usernameStatement)
        
        return userExists
    }
    
    //MARK: - Verify User Credentials
    
    ///Used for verifying the login user credentials
    ///- Parameters:
    ///   - username: String
    ///   - password: String
    private func verifyLoginCredentials(username: String,
                                        password: String) -> Bool {
        let verifyStatementString = """
                                    SELECT * FROM User WHERE
                                    Username='\(username)' AND
                                    Password = '\(password)';
                                    """
        var isValidAccount = false
        var verifyStatement: OpaquePointer?
        
        if sqlite3_prepare_v2(db,
                              verifyStatementString,
                              -1,
                              &verifyStatement,
                              nil) == SQLITE_OK {
            
            if sqlite3_step(verifyStatement) == SQLITE_ROW {
                isValidAccount = true
            }
        } else {
            debugPrint("SELECT query could not be prepared.")
        }
        
        sqlite3_finalize(verifyStatement)
        
        return isValidAccount
    }
}

//MARK: - UserSQLiteServiceType
extension UserSQLiteService: UserSQLiteServiceType {
    
    func insert(id: Int,
                username: String,
                password: String) {
        
        _ = self.insertUserData(id: id,
                                username: username,
                                password: password)
    }
    
    func login(username: String,
               password: String) -> Bool {
        
        let result = verifyLoginCredentials(username: username,
                                            password: password)
        return result
    }
}
