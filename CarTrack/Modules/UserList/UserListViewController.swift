//
//  UserListViewController.swift
//  CarTrack
//
//  Created by Shubham Raj on 25/03/23.
//

import UIKit

class UserListViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel: UserListViewModel = UserListViewModel()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView()
        loader.hidesWhenStopped = true
        return loader
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupActivityIndicator()
    }
    
    //MARK: - IBAction
    @IBAction func logoutClicked(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
}

// MARK: - Setup
private extension UserListViewController {
    private func setupView() {
        title = viewModel.navigationTitle
        viewModel.delegate = self
    }
    
    //Setting up the activity indicator view
    private func setupActivityIndicator() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicator.startAnimating()
    }
}

// MARK: - UITableViewDataSource
extension UserListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: UserListTableCell.reuseIdentifier,
            for: indexPath
        ) as? UserListTableCell else { return UITableViewCell() }
        
        cell.viewModel = viewModel.item(at: indexPath.row)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension UserListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        if let selectedUser = viewModel.getUser(at: indexPath.row) {
            self.pushUserDetailsViewController(user: selectedUser)
        }
    }
}

// MARK: - UserListViewModelDelegate
extension UserListViewController: UserListViewModelDelegate {
    func shouldReloadTableView() {
        activityIndicator.stopAnimating()
        tableView.reloadData()
    }
    
    func shouldShowErrorAlert() {
        activityIndicator.stopAnimating()
        self.showErrorAlert()
    }
}

// MARK: - Helper Methods
extension UserListViewController {
    
    private func pushUserDetailsViewController(user: CTUser) {
        let storyBoard: UIStoryboard = UIStoryboard(name: CTStoryboard.MAIN, bundle: nil)
        if let viewController = storyBoard.instantiateViewController(withIdentifier: "UserDetailsVC") as? UserDetailsVC {
            viewController.userDetail = user
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    private func showErrorAlert() {
        let alert = UIAlertController(title: CTConstants.Error,
                                      message: CTConstants.User_Error,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: CTConstants.OK,
                                      style: .cancel,
                                      handler: nil))
        self.present(alert,
                     animated: true)
    }
}
