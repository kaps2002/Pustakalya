import Foundation

@Observable
class HomeViewModel {
    var booksData: BooksData?
    var userData: Userdata?
    var booksGenreList = [String]()
    var searchTerm: String = ""
    
    func fetchBooks() {
        APIManager.shared.fetchBooks(from: "https://pustakalya.vercel.app/api/getBooks", authToken: UserDefaults.standard.string(forKey: "authToken") ?? "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjI5LCJuYW1lIjoia2FyYW4iLCJleHAiOjE3MTk3NDA3NjN9.jVkGzFhUXf0QTyNCH5gOaaZfWuoqfLZ8-bT_rUpNCQc") { [self] (success: Bool, response: BooksData?) in
            if success {
                // Handle successful response
                if let responseData = response {
                    booksData = responseData
                    if let booksData = booksData {
                        for genres in booksData.data {
                            booksGenreList.append(genres.genre)
                        }
                    }
                }
            } else {
                print("data nhi aaya")
            }
        }
    }
    
    func getUser() {
        APIManager.shared.getUser(from: "https://pustakalya.vercel.app/api/getUserDetails", authToken: UserDefaults.standard.string(forKey: "authToken") ?? "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjI5LCJuYW1lIjoia2FyYW4iLCJleHAiOjE3MTk3NDA3NjN9.jVkGzFhUXf0QTyNCH5gOaaZfWuoqfLZ8-bT_rUpNCQc") { [self] (success: Bool, response: Userdata?) in
            if success {
                if let responseData = response {
                    userData = response
                } else {
                    print("data ni aaya user ka")
                }
            }
        }
    }
    
    func filteredBooks(filters: Set<String>, booksData: BooksData) -> [Genre] {
        var temp: [Genre] = []
        for filter in filters {
            for genre in booksData.data {
                if filter == genre.genre {
                    temp.append(genre)
                }
            }
        }
        return temp
    }
}
