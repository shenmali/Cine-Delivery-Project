//
//  HomeViewModel.swift
//  Cinx-Delivery
//
//  Created by Ali on 18/08/2023.
//  Home Screen VModel

import Foundation
import RxSwift
import RxRelay

class HomeViewModel {
    private let homeUseCase: HomeUseCaseProtocol
    private let bag = DisposeBag()
    var deliveryBill: BehaviorRelay<[DeliveryBill]> = .init(value: [])
    var tag = 1
    init(homeUseCase: HomeUseCaseProtocol = HomeUseCaseImplmnt()) {
        self.homeUseCase = homeUseCase
    }
    // MARK: - viewDidLoad
    func viewDidLoad() {
        GetDeliveryBillsItems()
    }
    
    func GetDeliveryBillsItems() {
        homeUseCase.GetDeliveryBillsItems().subscribe(onNext: { [weak self] data in
            guard let self = self else { return }
            switch self.tag == 1 {
            case true:
                let filteredBillsWithFlag0 = data.Data?.DeliveryBills.filter { $0.DLVRY_STATUS_FLG == "0" } ?? []
                self.deliveryBill.accept(filteredBillsWithFlag0)
                
            case false:
                let filteredBillsWithFlagOther = data.Data?.DeliveryBills.filter { $0.DLVRY_STATUS_FLG != "0" } ?? []
                self.deliveryBill.accept(filteredBillsWithFlagOther)
            }
        }).disposed(by: bag)
    }
}
