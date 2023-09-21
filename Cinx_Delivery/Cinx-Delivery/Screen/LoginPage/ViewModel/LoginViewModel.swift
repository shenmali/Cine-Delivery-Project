//
//  LoginViewModel.swift
//  Cinx-Delivery
//
//  Created by Ali on 18/08/2023.
//  Login Screen VModel

import Foundation
import RxSwift
import RxRelay

class LoginViewModel {
    let userIDTextField: BehaviorRelay<String> = .init(value: "")
    let password: BehaviorRelay<String> = .init(value: "")
    let showAlert = PublishSubject<String>()
    let successLogin: BehaviorRelay<Bool> = .init(value: false)
    var loadingBehavior = BehaviorRelay<Bool>(value: false)
    private let loginUseCase: LoginUseCaseProtocol
    private let bag = DisposeBag()
    // MARK: - Init
    init(loginUseCase: LoginUseCaseProtocol = LoginUseCaseImplmnt()) {
        self.loginUseCase = loginUseCase
    }
    // MARK: - viewDidLoad
    func viewDidLoad() {
        checkLoginData()
    }
    // Subscribe User Information Input
    func checkLoginData() {
        guard !userIDTextField.value.isEmpty && !password.value.isEmpty else {
            showAlert.onNext(AppError.enterAllFields.localizedDescription)
            return
        }
        loadingBehavior.accept(true)
        loginUseCase.fetchUserData(userID: userIDTextField.value, password: password.value).subscribe(onNext: { [weak self] data in
            guard let self = self else {return}
            if data.Result?.ErrMsg == "Successful"{
                self.successLogin.accept(true)
                self.loadingBehavior.accept(false)
                UserDefaults.standard.set(self.userIDTextField.value, forKey: "userID")
                UserDefaults.standard.set(data.Data?.DeliveryName, forKey: "userName")
            } else {
                self.loadingBehavior.accept(false)
                self.successLogin.accept(false)
                self.showAlert.onNext(AppError.invalidEmailOrPassword.localizedDescription)

            }
        }).disposed(by: bag)
        
    }
}
