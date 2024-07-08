import Foundation

@Observable
class HomeViewModel {
    var booksData: BooksData?
    var userData: Userdata?
    var booksGenreList = [String]()
    var searchTerm: String = ""
    var btnGenreList = [Btn]()
    var genreBooks: Genre?
    
    func fetchBooks() {
        APIManager.shared.fetchBooks(from: "https://pustakalya.vercel.app/api/getBooks/allBooks", authToken: UserDefaults.standard.string(forKey: "authToken") ?? "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjMzLCJuYW1lIjoiWW95byJ9.tbu8SuxCItC-7upM0TBDbtuUc6hs2drfZ9QcOep4NA4") { [self] (success: Bool, response: BooksData?) in
            if success {
                // Handle successful response
                if let responseData = response {
                    booksData = responseData
                    if let booksData = booksData {
                        for genres in booksData.data {
                            booksGenreList.append(genres.genre)
                            btnGenreList.append(Btn(btnTitle: genres.genre, isClicked: false))
                        }
                    }
                }
            } else {
                print("data nhi aaya")
            }
        }
    }
    
    func getUser() {
        APIManager.shared.getUser(from: "https://pustakalya.vercel.app/api/getUserDetails", authToken: UserDefaults.standard.string(forKey: "authToken") ?? "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjMzLCJuYW1lIjoiWW95byJ9.tbu8SuxCItC-7upM0TBDbtuUc6hs2drfZ9QcOep4NA4") { [self] (success: Bool, response: Userdata?) in
            if success {
                if let responseData = response {
                    userData = response
                } else {
                    print("data ni aaya user ka")
                }
            }
        }
    }
    
    func getGenre(genre: String) {
        APIManager.shared.getBooks(from: "https://pustakalya.vercel.app/api/getBooks/\(genre)", authToken: UserDefaults.standard.string(forKey: "authToken") ?? "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjMzLCJuYW1lIjoiWW95byJ9.tbu8SuxCItC-7upM0TBDbtuUc6hs2drfZ9QcOep4NA4") { [self] (success: Bool, response: Genre?) in
            if success {
                if let responseData = response {
                    genreBooks = response
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
