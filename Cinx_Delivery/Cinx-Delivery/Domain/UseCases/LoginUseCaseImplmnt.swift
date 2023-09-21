//
//  LoginUseCase.swift
//  Cinx-Delivery
//
//  Created by Ali on 18/08/2023.
//

import Foundation
import RxSwift

class LoginUseCaseImplmnt: LoginUseCaseProtocol {
    // MARK: - Variables
    private let repo: LoginRepoProtocol
    
    // MARK: - Init
    init(repo: LoginRepoProtocol = LoginRepoImplmnt()) {
        self.repo = repo
    }

    func fetchUserData(userID: String, password: String) -> RxSwift.Observable<UserData> {
        repo.fetchUserData(userID: userID, password: password)
    }
    
    
    
}
