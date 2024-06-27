//
//  SignInModelData.swift
//  Pustakalya
//
//  Created by Roro on 16/06/24.
//

import Foundation

struct AuthModelData: Codable {
    let message: String
    let success: Bool
    let token: String
}

struct Userdata: Codable {
    let data: Data
    struct Data: Codable {
        let name: String
        let email: String
        let dob: DateComponents?
        let address: String?
    }
}


