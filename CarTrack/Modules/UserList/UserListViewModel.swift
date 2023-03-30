//
//  UserListViewModel.swift
//  CarTrack
//
//  Created by Shubham Raj on 25/03/23.
//

import Foundation

final class UserListViewModel {
    
    var observerBlock:((_ observerType: ObserverTypeEnum) -> Void)?
    
    private var networkManager: NetworkManager
    private var items: [UserListCellVM] = []
    
    private var userList: [CTUser] = [] {
        didSet {
            observerBlock?(.dataLoaded)
        }
    }
    
    var dataSource: [CTUser] {
        return userList
    }
    
    init(manager: NetworkManager = NetworkManager()) {
        self.networkManager = manager
    }

    func fetchUsers() {
        self.observerBlock?(.dataLoading)
        UserListLoader.fetchUsers(
            manager: networkManager,
            completion: { [weak self] response in
                switch response {
                case let .success(users):
                    self?.userList = users
                    let viewModels = users.compactMap { UserListCellVM(user: $0) }
                    self?.items.append(contentsOf: viewModels)

                case let .failure(error):
                    print(error)
                    self?.observerBlock?(.dataFailed)
                }
            }
        )
    }
}


extension UserListViewModel {
    
    func getUser(at index: Int) -> CTUser? {
        if userList.count > index {
            return userList[index]
        }
        return nil
    }
    
    func item(at index: Int) -> UserListCellVM? {
        if items.count > index {
            return items[index]
        }
        return nil
    }
    
    var numberOfSections: Int {
        1
    }
    
    var navigationTitle: String {
        return CTConstants.Users
    }
}
