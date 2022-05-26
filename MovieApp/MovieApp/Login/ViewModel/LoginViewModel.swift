//
//  LoginViewModel.swift
//  MovieApp
//
//  Created by soujanya Balusu on 24/05/22.
//

import Foundation

protocol LoginViewModelInputProtocol {
    /// Method to fetch Movies list from server
    func loginAPI(username: String,password: String,callback: @escaping (_ success: Bool) -> Void)
}


class LoginViewModel {
    // Input
    /// This variable will only allow input actions
    var input: LoginViewModelInputProtocol { self }
    /// Network manager handle all the API calls
    var networkManager: NetworkManagerProtocol = NetworkManager()
    var reloadData: Dynamic<Bool> = Dynamic(false)
    ///LOgin Object object contains token and expiry time session
    var loginObj  : login?
    
}

extension LoginViewModel: LoginViewModelInputProtocol {
    
    ///API CALL on Login ACtion
    func loginAPI(username: String,password: String,callback: @escaping (_ success: Bool) -> Void) {
        if Reachability.isConnectedToNetwork(){
            networkManager.loginAPI(with: username,password: password,completion: { [weak self] loginModel in
                self?.loginObj = loginModel
                ///Reload the login controller on completion loop
                self?.reloadData.value = true
                if loginModel == nil { callback(false) }
                else{ callback(true) }
            })
        }
        else{
            debugPrint("Internet Connection not Available!")
        }
        
    }
    
}
