//
//  LoginRepoImple.swift
//  Cinx-Delivery
//
//  Created by Ali on 18/08/2023.
//

import Foundation
import RxSwift

class LoginRepoImplmnt: LoginRepoProtocol {
    
    private let networkService : APIService
    
    init(networkService: APIService = NetworkService()) {
        self.networkService = networkService
    }
    
    // MARK: - Fetch User Data
    func fetchUserData(userID: String, password: String) -> RxSwift.Observable<UserData> {
        let baseUrl = URL(string: "\(ConstVar.baseUrl)\(ConstVar.checkDeliveryLogin)")!
        
        let requestBody = [
            "Value": [
                "P_LANG_NO": ConstVar.LanguageNU,
                "P_DLVRY_NO": userID,
                "P_PSSWRD": password
            ]
        ]
        
        do {
            let requestBodyData = try JSONSerialization.data(withJSONObject: requestBody, options: [])
            
            var request = URLRequest(url: baseUrl)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = requestBodyData
            
            return networkService.fetch(urlRequest: request)
                .asObservable()
                .flatMap { data -> Observable<UserData> in
                    do {
                        let user = try JSONDecoder().decode(UserData.self, from: data)
                        return Observable.just(user)
                    } catch {
                        return Observable.error(error) // More specific error handling here
                    }
                }
        } catch {
            return Observable.error(error) // More specific error handling here
        }
    }
}
