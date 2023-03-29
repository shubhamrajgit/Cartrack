//
//  LoginViewController.swift
//  CarTrack
//
//  Created by Shubham Raj on 25/03/23.
//

import UIKit
import TextFieldEffects

class LoginViewController: BaseViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var logoImageV: UIImageView!
    @IBOutlet weak var loginTitle: UILabel!
    @IBOutlet weak var usernameTF: HoshiTextField!
    @IBOutlet weak var passwordTF: HoshiTextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginBtnAnimationView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private lazy var viewModel: LoginViewModelType = { [weak self] in
        return LoginViewModel(with: LoginService())
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTextFields()
    }
    
    private func setupTextFields() {
        usernameTF.addTarget(self, action: #selector(textFieldDidChange),
                             for: .editingChanged)
        passwordTF.addTarget(self, action: #selector(textFieldDidChange),
                             for: .editingChanged)
    }
    
    //MARK: - IBActions
    @IBAction func didClickLoginButton(_ sender: Any) {
        self.view.endEditing(true)
        self.showLoadingIndicator(true)
        viewModel.signIn(username: usernameTF.text ?? "",
                         password: passwordTF.text ?? "") { [weak self] success in
            DispatchQueue.main.async {
                self?.showLoadingIndicator(false)
                if success {
                    print("Login Success")
                    self?.didSuccessLogin()
                } else {
                    print("Login Failed")
                    self?.didLoginFailed()
                }
            }
            
        }
    }
    
    @objc func textFieldDidChange() {
        self.validateData()
    }
}

//MARK: - Helper Methods
extension LoginViewController {
    
    private func didSuccessLogin() {
        self.passwordTF.text = ""
        self.validateData()
        self.presentUserListViewController()
    }
    
    private func didLoginFailed() {
        self.showErrorAlert()
        self.passwordTF.text = ""
        self.validateData()
    }
    
    private func presentUserListViewController() {
        let storyBoard: UIStoryboard = UIStoryboard(name: CTStoryboard.MAIN,
                                                    bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "UserListNavigationController")
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController,
                     animated: true,
                     completion: nil)
    }
}

//MARK: - Helper Methods
extension LoginViewController {
    
    private func validateData() {
        let usernameValue = usernameTF.text?.trimmedValue() ?? ""
        let passwordValue = passwordTF.text?.trimmedValue() ?? ""
        let isSuccess = usernameValue.count > 0 && passwordValue.count > 0
        self.changeLoginButtonState(isSuccess)
    }
    
    private func changeLoginButtonState(_ isEnabled: Bool) {
        self.loginBtnAnimationView.isHidden = isEnabled
    }
    
    private func showErrorAlert() {
        let alert = UIAlertController(title: CTConstants.Error,
                                      message: CTConstants.Login_Error,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: CTConstants.OK,
                                      style: .cancel,
                                      handler: nil))
        self.present(alert,
                     animated: true)
    }
    
    private func showLoadingIndicator(_ show: Bool) {
        if show {
            self.loginBtnAnimationView.isHidden = false
            self.loginButton.setTitle("", for: .normal)
            self.activityIndicator.startAnimating()
        } else {
            self.loginButton.setTitle(CTConstants.LOGIN, for: .normal)
            self.activityIndicator.stopAnimating()
        }
    }
}


