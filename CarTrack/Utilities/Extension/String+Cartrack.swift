//
//  String+Cartrack.swift
//  CarTrack
//
//  Created by Shubham Raj on 25/03/23.
//

import Foundation

extension String {
    
    func trimmedValue() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
