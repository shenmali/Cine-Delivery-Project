//
//  HomeUseCase.swift
//  Cinx-Delivery
//
//  Created by Ali on 19/09/2023.
//

import Foundation
import RxSwift

class HomeUseCaseImplmnt: HomeUseCaseProtocol  {
    
    private let repo: HomeRepoProtocol
    
    init(repo: HomeRepoProtocol = HomeRepoImplmnt()) {
        self.repo = repo
    }
    
    func GetDeliveryBillsItems() -> RxSwift.Observable<DeliveryResponse> {
        repo.GetDeliveryBillsItems()
    }
}
