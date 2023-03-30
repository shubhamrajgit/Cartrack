//
//  UserDetailsVC.swift
//  CarTrack
//
//  Created by Shubham Raj on 25/03/23.
//

import UIKit

class UserDetailsVC: UIViewController, CTStoryboardInstantiable {

    @IBOutlet weak var tableView: UITableView!
    var userDetail: CTUser?
    
    private var userDetailVM: UserDetailsVM?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        setupTableView()
    }
    
    private func setupViewModel() {
        if let userData = userDetail {
            userDetailVM = UserDetailsVM(userData: userData)
        }
    }
    
    private func setupTableView() {
        title = userDetailVM?.navigationTitle
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
    }
}

// MARK: - UITableViewDataSource
extension UserDetailsVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        
        return userDetailVM?.getItemsCount() ?? 0
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            return self.preparePersonalInfoCell(indexPath)
        case 1:
            return self.prepareCompanylInfoCell(indexPath)
        case 2:
            return self.prepareAddressInfoCell(indexPath)
        default:
            break
        }
        return UITableViewCell()
    }
}

// MARK: - Helper Methods
extension UserDetailsVC {
    
    private func preparePersonalInfoCell(_ indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: UserInfoCell.reuseIdentifier,
            for: indexPath
        ) as? UserInfoCell, let userData = userDetail else { return UITableViewCell() }
        
        cell.viewModel = UserInfoCellVM(user: userData)
        return cell
    }
    
    private func prepareCompanylInfoCell(_ indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: UserCompanyCell.reuseIdentifier,
            for: indexPath
        ) as? UserCompanyCell, let userData = userDetail else { return UITableViewCell() }
        
        cell.viewModel = UserInfoCellVM(user: userData)
        return cell
    }
    
    private func prepareAddressInfoCell(_ indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: UserAddressCell.reuseIdentifier,
            for: indexPath
        ) as? UserAddressCell, let userData = userDetail else { return UITableViewCell() }
        
        cell.viewModel = UserInfoCellVM(user: userData)
        return cell
    }
}
