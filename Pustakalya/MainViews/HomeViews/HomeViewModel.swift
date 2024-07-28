import Foundation

@Observable
class HomeViewModel {
    var booksData: BooksData?
    var userData: Userdata?
    var booksGenreList = [String]()
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
    
    func logout() {
        UserDefaults.standard.removeObject(forKey: "authToken")
    }
    
    func deleteUser(completion: @escaping (Bool) -> Void) {
        APIManager.shared.deleteUser(from: "https://pustakalya.vercel.app/api/deleteUser", authToken: UserDefaults.standard.string(forKey: "authToken") ?? "") { res in
            if res {
                completion(true)
            } else {
                completion(false)
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
    
    func searchBooks(search: String) -> BooksData {
        var filteredBooksData: BooksData = BooksData(data: [])
        guard let booksData = booksData else {
            return BooksData.sample
        }
        for genre in booksData.data {
            var searchGenre: Genre = Genre(genre: "", books: [])
            for book in genre.books {
                if book.title.lowercased().contains(search.lowercased()) {
                    searchGenre.genre = genre.genre
                    searchGenre.books.append(book)
                }
            }
            if !searchGenre.books.isEmpty {
                filteredBooksData.data.append(searchGenre)
            }
        }
        return filteredBooksData
    }
}
