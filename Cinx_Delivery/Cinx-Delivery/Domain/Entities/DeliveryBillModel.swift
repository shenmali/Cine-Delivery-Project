//
//  DeliveryBillModel.swift
//  Cinx-Delivery
//
//  Created by Ali on 19/09/2023.
//

import Foundation
// MARK: - Delivery Bill
struct DeliveryBill: Codable {

    let BILL_AMT: String?
    let BILL_DATE: String?
    let BILL_NO: String?
    let BILL_SRL: String?
    let BILL_TIME: String?
    let BILL_TYPE: String?
    let CSTMR_ADDRSS: String?
    let CSTMR_APRTMNT_NO: String?
    let CSTMR_BUILD_NO: String?
    let CSTMR_FLOOR_NO: String?
    let CSTMR_NM: String?
    let DLVRY_AMT: String?
    let DLVRY_STATUS_FLG: String?
    let LATITUDE: String?
    let LONGITUDE: String?
    let MOBILE_NO: String?
    let RGN_NM: String?
    let TAX_AMT: String?
}

// MARK: - Delivery Data
struct DeliveryData: Codable {
    let DeliveryBills: [DeliveryBill]
}
// MARK: - Delivery Response
struct DeliveryResponse: Codable {
    let Data: DeliveryData?
    let Result: Result?
}
