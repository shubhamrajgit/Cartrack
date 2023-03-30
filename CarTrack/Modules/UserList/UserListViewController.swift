//
//  UserListViewController.swift
//  CarTrack
//
//  Created by Shubham Raj on 25/03/23.
//

import UIKit

class UserListViewController: UIViewController, CTStoryboardInstantiable {

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
        start()
    }
    
    //MARK: - IBAction
    @IBAction func logoutClicked(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    
    //Start View Model
    private func start() {
        viewModel.fetchUsers()
        viewModel.observerBlock = { [weak self] (state) in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                switch state {
                case .dataLoaded:
                    debugPrint("Data Loaded")
                    self?.tableView.reloadData()
                case .dataFailed:
                    debugPrint("Data Failed")
                    self?.showErrorAlert()
                    
                case .dataLoading:
                    debugPrint("Data Loading")
                    self?.activityIndicator.startAnimating()
                    
                default:
                    debugPrint("Default handling")
                }
            }
        }
    }
}

// MARK: - Setup
private extension UserListViewController {
    private func setupView() {
        title = viewModel.navigationTitle
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
        return viewModel.dataSource.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: UserListTableCell.reuseIdentifier,
            for: indexPath
        ) as? UserListTableCell else { return UITableViewCell() }
        
        if let cellVM = viewModel.item(at: indexPath.row) {
            cell.viewModel = cellVM
        }
        
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

// MARK: - Helper Methods
extension UserListViewController: CTAlertable {
    
    private func pushUserDetailsViewController(user: CTUser) {
        let viewController = UserDetailsVC.instantiateViewController()
        viewController.userDetail = user
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func showErrorAlert() {
        self.showAlert(title: CTConstants.Error,
                       message: CTConstants.User_Error)
    }
}
