//
//  String+CartrackTests.swift
//  CarTrackTests
//
//  Created by Shubham Raj on 29/03/23.
//

import XCTest
@testable import CarTrack

final class String_CartrackTests: XCTestCase {
    
    func testTrimmedValue() {
        let sampleString = "  test string  "
        
        let result = sampleString.trimmedValue()
        
        let expectedResult = "test string"
        
        XCTAssertEqual(result, expectedResult)
    }
}
