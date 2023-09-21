//
//  HomeUseCaseProtocol.swift
//  cinx
//
//  Created by Ali on 17.09.2023.
//

import Foundation
import RxSwift

protocol HomeUseCaseProtocol{
    func GetDeliveryBillsItems() -> RxSwift.Observable<DeliveryResponse>
}
