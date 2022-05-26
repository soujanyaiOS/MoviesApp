//
//  BaseViewController.swift
//  MovieApp
//
//  Created by soujanya Balusu on 24/05/22.
//

import UIKit

class BaseViewController: UIViewController {
    var backButton: UIButton?
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeBack()

        // Do any additional setup after loading the view.
    }
    
    private func customizeBack() {
        let fancyImage = UIImage(named: "nav_back_icon")
        let fancyAppearance = UINavigationBarAppearance()
        fancyAppearance.configureWithDefaultBackground()
        fancyAppearance.setBackIndicatorImage(fancyImage, transitionMaskImage: fancyImage)
        navigationController?.navigationBar.scrollEdgeAppearance = fancyAppearance
    }
    
    @objc func backClickedBase(_: UIButton?) {
       
            navigationController?.popViewController(animated: true)
       
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        title = ""
    }
    

}
extension UIViewController{
func showToast(message : String, seconds: Double){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = .black
        alert.view.alpha = 0.5
        alert.view.layer.cornerRadius = 15
        self.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }
 }
