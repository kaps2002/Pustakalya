import Foundation

struct BooksData: Codable {
    var data: [Genre]
    
    static var sample: BooksData {
        return BooksData(data: [Genre(genre: "Fiction", books: [Book(id: "1", eTag: "abcd", title: "Harry", subtitle: "Potter", genreType: "Fiction", author: "JK Rowling", description: "Harry potter is nice", thumbnail: "", rating: "4.5", price: 500)])])
    }
}

struct Genre: Codable {
    var genre: String
    var books: [Book]
}

struct Book: Codable {
    var id: String
    var eTag: String
    var title: String
    var subtitle: String
    var genreType: String
    var author: String
    var description: String
    var thumbnail: String
    var rating: String
    var price: Int
}

struct Btn: Codable {
    var btnTitle: String
    var isClicked: Bool
}
