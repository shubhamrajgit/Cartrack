//
//  UserListLoader.swift
//  CarTrack
//
//  Created by Shubham Raj on 28/03/23.
//

import Foundation

struct UserListLoader {
    
    static func fetchUsers(manager: NetworkManager = NetworkManager(),
                           completion: @escaping (Result<[CTUser], Error>) -> Void
    ) {
        guard let url = URL(string: CTAPIEndpoints().users) else { return }
        
        manager.makeRequest(
            with: url,
            decode: [CTUser].self,
            completionHandler: { response in
                switch response {
                case let .success(result):
                    completion(.success(result))
                case let .failure(error):
                    completion(.failure(error))
                }
            }
        )
    }
}
