//
//  HomeRepoProtocol.swift
//  Cinx-Delivery
//
//  Created by Ali on 19/09/2023.
//

import Foundation
import RxSwift

protocol HomeRepoProtocol {
    func GetDeliveryBillsItems() -> RxSwift.Observable<DeliveryResponse>
}
