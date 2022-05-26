//
//  LoginViewController.swift
//  MovieApp
//
//  Created by soujanya Balusu on 24/05/22.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var activityLoader: UIActivityIndicatorView!
    private var authenticationToken: String = ""
    @IBOutlet weak var password_txt: UITextField!
    @IBOutlet weak var username_txt: UITextField!
    var viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handleActivity(true)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    ///LOGIN Click for API call authentication
    @IBAction func loginAction(_ sender: Any) {
        handleActivity(false)
        viewModel.loginAPI(username: username_txt.text ?? "", password: password_txt.text ?? "") { [weak self ]success in
            self?.handleActivity(true)
            if success {
                let mainSB = UIStoryboard(name: "Main", bundle: nil)
                let vc = mainSB.instantiateViewController(withIdentifier: "MoviesListViewController") as! MoviesListViewController
                if self?.viewModel.loginObj?.token != nil, !(self?.viewModel.loginObj?.token.isEmpty ?? false) {
                    UserDefaults.standard.set(self?.viewModel.loginObj?.token ?? "", forKey: "accessToken")
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            }
            else{
                self?.showErrorAlert()
            }
        }
    }
    
    private  func showErrorAlert() {
        let message = NSLocalizedString("LOGIN_ALERT", comment: "")
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        self.present(alert, animated: true)
        // Auto disappear in for error alert
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.0) {
            alert.dismiss(animated: true)
        }
    }
    
    ///Handler for activity loader
    private func handleActivity(_ hidden: Bool) {
        activityLoader.isHidden = hidden
        if hidden {
            activityLoader.stopAnimating()
        }
        else{
            activityLoader.startAnimating()
        }
    }
}


