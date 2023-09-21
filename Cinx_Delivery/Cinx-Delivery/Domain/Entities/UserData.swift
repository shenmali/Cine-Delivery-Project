//
//  UserData.swift
//  Cinx-Delivery
//
//  Created by Ali on 18/08/2023.
//

import Foundation

// MARK: - UserData
struct UserData : Codable{
    let Data: User?
    let Result: Result?
}

// MARK: - DataClass
struct User: Codable {
    let DeliveryName: String?
}

// MARK: - Result
struct Result: Codable {
    let ErrMsg: String?
    let ErrNo: Int?
}
