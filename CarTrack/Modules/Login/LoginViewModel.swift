//
//  LoginViewModel.swift
//  CarTrack
//
//  Created by Shubham Raj on 25/03/23.
//

import Foundation

//MARK: - Protocols
protocol LoginViewModelType {
    
    func signIn(username: String,
                password: String,
                completion: @escaping (Bool) -> ())
}

//MARK: - LoginViewModel
class LoginViewModel: LoginViewModelType {
    
    private var loginService: LoginServiceType?
    
    init(with loginService: LoginServiceType) {
        self.loginService = loginService
    }
    
    ///signIn Callback
    func signIn(username: String,
                password: String,
                completion: @escaping (Bool) -> ()) {
        
        self.loginService?.login(username: username,
                                 password: password,
                                 completion: { success in
            completion(success)
        })
    }
}
