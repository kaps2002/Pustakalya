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
    let genre: String
    let books: [Book]
}

struct Book: Codable {
    let id: String
    let eTag: String
    let title: String
    let subtitle: String
    let genreType: String
    let author: String
    let description: String
    let thumbnail: String
    let rating: String
    let price: Int
}


