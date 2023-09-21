//
//  LoginRepoProtocol.swift
//  Cinx-Delivery
//
//  Created by Ali on 18/08/2023.
//

import Foundation
import RxSwift

protocol LoginRepoProtocol {
    func fetchUserData(userID: String, password: String) -> RxSwift.Observable<UserData>
}
