//
//  HomeRepoImple.swift
//  Cinx-Delivery
//
//  Created by Ali on 19/09/2023.
//

import Foundation
import RxSwift

class HomeRepoImplmnt: HomeRepoProtocol {
    
    private let networkService : APIService
    
    init(networkService :APIService = NetworkService()){
        self.networkService = networkService
    }
    // MARK: - Get Delivery Bills Items
    func GetDeliveryBillsItems() -> RxSwift.Observable<DeliveryResponse> {
        let baseUrl = URL(string: "\(ConstVar.baseUrl)\(ConstVar.getDeliveryBillsItems)")!
        let userID = UserDefaults.standard.string(forKey: "userID")!
        let requestBody = [
            "Value": [
                "P_DLVRY_NO": userID,
                "P_LANG_NO": ConstVar.LanguageNU
            ]
        ]
        do {
            
            let requestBodyData = try JSONSerialization.data(withJSONObject: requestBody,options: [])
            var request = URLRequest(url: baseUrl)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = requestBodyData
            return networkService.fetch(urlRequest: request).asObservable().flatMap { data -> Observable <DeliveryResponse> in
                do {
                    let deliveryBillsItems = try JSONDecoder().decode(DeliveryResponse.self, from: data)
                    return Observable.just(deliveryBillsItems)
                } catch {
                    return Observable.error(error)
                }
            }
        } catch {
            return Observable.error(error)
        }
        
    }
    
    
}
