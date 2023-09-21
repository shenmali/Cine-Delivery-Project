//
//  LoginUseCaseProtocol.swift
//  cinx
//
//  Created by Ali on 17.09.2023.
//

import Foundation
import RxSwift

protocol LoginUseCaseProtocol  {
    func fetchUserData(userID: String, password: String) -> RxSwift.Observable<UserData>
}
