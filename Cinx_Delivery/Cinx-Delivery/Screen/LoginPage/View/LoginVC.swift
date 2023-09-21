//
//  LoginVC.swift
//  Cinx-Delivery
//
//  Created by Ali on 18/08/2023.
//  Login Screen

import UIKit
import RxSwift
import RxCocoa

class LoginVC: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var userIDTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    // MARK: - Variables
    private let bag = DisposeBag()
    private var viewModel: LoginViewModel
    // MARK: - Init
    init(viewModel: LoginViewModel = LoginViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: LoginVC.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bindingToViewModel()
        viewModel.viewDidLoad()
        loginButtonSubscription()
        showAlertMessage()
        subscribeToResponse()
        subscribeToLoading()
    }
    // MARK: - Show Alert
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Alart", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    // MARK: - bind To View Model
    private func bindingToViewModel() {
        userIDTextField
            .rx
            .text
            .orEmpty
            .bind(to: viewModel.userIDTextField)
            .disposed(by: bag)
        
        passwordTextField
            .rx
            .text
            .orEmpty
            .bind(to: viewModel.password)
            .disposed(by: bag)
    }
    
    private func loginButtonSubscription() {
        loginButton.rx.tap.subscribe(onNext: {[weak self] _ in
            guard let self = self else  { return }
            self.viewModel.checkLoginData()
        }).disposed(by: bag)
        
    }
    
    // MARK: - Method to show & hidden loader
    private func subscribeToLoading() {
        viewModel.loadingBehavior.subscribe(onNext: { (isLoading) in
            if isLoading {
                self.activityIndicator.startAnimating()
            }
            else {
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.hidesWhenStopped = true
                }
            }
        }).disposed(by: bag)
    }
    
    private func showAlertMessage() {
        // Subscribe to showAlert subject to handle alerts
        viewModel.showAlert.observe(on: MainScheduler.instance)
            .subscribe(onNext: {  message in
                self.showAlert(message: message)
            })
            .disposed(by: bag)
    }
    
    private func subscribeToResponse() {
        viewModel.successLogin.observe(on: MainScheduler.instance)
            .subscribe(onNext: {  isLogin in
                switch isLogin {
                case true:
                    let vc = HomeVC()
                    self.navigationController?.pushViewController(vc, animated: true)
                case false:
                    break
                }
            }).disposed(by: bag)
    }
}
