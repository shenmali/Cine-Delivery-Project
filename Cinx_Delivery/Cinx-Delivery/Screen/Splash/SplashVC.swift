//
//  SplashVC.swift
//  Cinx-Delivery
//
//  Created by Ali on 18/08/2023.
// This is Slash Screen

import UIKit

class SplashVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let navigationController = UINavigationController()
            navigationController.setViewControllers([LoginVC()], animated: true)
            navigationController.modalPresentationStyle = .fullScreen
            self.present(navigationController, animated: true, completion: nil)
        }
    }

}
