//
//  UserListViewModel.swift
//  CarTrack
//
//  Created by Shubham Raj on 25/03/23.
//

import Foundation

protocol UserListViewModelDelegate: AnyObject {
    func shouldReloadTableView()
    func shouldShowErrorAlert()
}

final class UserListViewModel {
    
    private var networkManager: NetworkManager
    private var items: [UserListCellVM] = []
    private var userList: [CTUser] = []
    
    weak var delegate: UserListViewModelDelegate?

    init(manager: NetworkManager = NetworkManager()) {
        self.networkManager = manager
        fetchUsers()
    }

    func fetchUsers() {
        UserListLoader.fetchUsers(
            manager: networkManager,
            completion: { [weak self] response in
                switch response {
                case let .success(users):
                    self?.userList = users
                    let viewModels = users.compactMap { UserListCellVM(user: $0) }

                    self?.items.append(contentsOf: viewModels)

                    DispatchQueue.main.async {
                        self?.delegate?.shouldReloadTableView()
                    }
                case let .failure(error):
                    print(error)
                    DispatchQueue.main.async {
                        self?.delegate?.shouldShowErrorAlert()
                    }
                    
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
    
    var numberOfItems: Int {
        items.count
    }
    
    var numberOfSections: Int {
        1
    }
    
    var navigationTitle: String {
        return "Users"
    }
}
