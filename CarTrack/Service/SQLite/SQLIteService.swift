//
//  SQLIteService.swift
//  CarTrack
//
//  Created by Shubham Raj on 25/03/23.
//

import Foundation
import SQLite3

class SQLiteService {
    
    //MARK: - OPRN DB
    func openDatabase(dbPath: String) -> OpaquePointer? {
        
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbPath)
        var db: OpaquePointer? = nil
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
            return nil
        } else {
            print("Successfully opened connection to database at \(dbPath)")
            return db
        }
    }
}
