//
//  UserListLoaderTests.swift
//  CarTrackTests
//
//  Created by Shubham Raj on 29/03/23.
//

import XCTest
@testable import CarTrack

class NetworkSessionMock: NetworkSession {
    private(set) var requestUrl: URL?

    var data: Data?
    var error: Error?

    func loadData(with urlRequest: URLRequest,
                  completionHandler: @escaping (Data?, Error?) -> Void) {
        requestUrl = urlRequest.url
        completionHandler(data, error)
    }
}

final class UserListLoaderTests: XCTestCase {
    
    func testSuccessfullResponse() {
        let fixtureData = DataFixtures.userListData
        
        let networkSession = NetworkSessionMock()
        networkSession.data = fixtureData
        networkSession.error = nil
        
        let networkManager = NetworkManager(session: networkSession)
        
        var expectedResults: [CTUser]?
        var expectedError: Error?
        
        UserListLoader.fetchUsers(
            manager: networkManager,
            completion: { response in
                switch response {
                case let .success(result):
                    expectedResults = result
                case let .failure(error):
                    expectedError = error
                }
            }
        )
        
        let expectedRequestUrl = URL(string: "https://jsonplaceholder.typicode.com/users")
        
        XCTAssert(networkSession.requestUrl == expectedRequestUrl)
        XCTAssertNotNil(expectedResults)
        XCTAssertTrue(expectedResults?.count ?? 0 > 0)
        XCTAssertNil(expectedError)
    }
    
    func testFailureResponse() {
        let fixtureData = DataFixtures.userListData_Failure
        
        let networkSession = NetworkSessionMock()
        networkSession.data = fixtureData
        networkSession.error = nil
        
        let networkManager = NetworkManager(session: networkSession)
        
        var expectedResults: [CTUser]?
        var expectedError: Error?
        
        UserListLoader.fetchUsers(
            manager: networkManager,
            completion: { response in
                switch response {
                case let .success(result):
                    expectedResults = result
                case let .failure(error):
                    expectedError = error
                }
            }
        )
        
        XCTAssertNil(expectedResults)
        XCTAssertNotNil(expectedError)
    }
    
}
