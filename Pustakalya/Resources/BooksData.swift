//
//  BooksData.swift
//  Pustakalya
//
//  Created by Roro on 17/06/24.
//

import Foundation

struct BooksData: Codable {
    let data: [Genre]
    
    static var sample: BooksData {
        return BooksData(data: [Genre(genre: "Fiction", books: [Book(id: "1", eTag: "abcd", title: "Harry", subtitle: "Potter", genreType: "Fiction", author: "JK Rowling", description: "Harry potter is nice", thumbnail: "", rating: "4.5", price: 500)])])
    }
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


