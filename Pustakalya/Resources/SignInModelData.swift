//
//  SignInModelData.swift
//  Pustakalya
//
//  Created by Roro on 16/06/24.
//

import Foundation

struct SignInModelData: Codable {
    let message: String
    let success: Bool
    let data: Data
    let token: String
}

struct Data: Codable {
    let name: String
    let email: String
    let dob: DateComponents?
    let address: String?
}

struct BooksData: Codable {
    
}
