//
//  BooksData.swift
//  Pustakalya
//
//  Created by Roro on 17/06/24.
//

import Foundation

struct BooksData: Codable {
    let data: [Genre]
}

struct Genre: Codable {
    let items: [Book]
}

struct Book: Codable {
    let id: String
    let etag: String
    let volumeInfo: VolumeInfo
}

struct VolumeInfo: Codable {
    let title: String
    let authors: [String]?
    let description: String?
    let imageLinks: ImageLinks?
    
}

struct ImageLinks: Codable {
    let thumbnail: String
}

