import Foundation

@Observable
class HomeViewModel {
    var booksData: BooksData?
    var userData: Userdata?
    var booksGenreList = [String]()
    var searchTerm: String = ""
    
    func fetchBooks() {
        APIManager.shared.fetchBooks(from: "https://pustakalya.vercel.app/api/getBooks", authToken: UserDefaults.standard.string(forKey: "authToken") ?? "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjI5LCJuYW1lIjoia2FyYW4iLCJleHAiOjE3MTk2NDc1OTJ9.S8BPM40qw4KDeC-dK59VZtFr78ae1SkBzxjA2veaGU8") { [self] (success: Bool, response: BooksData?) in
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
        APIManager.shared.getUser(from: "https://pustakalya.vercel.app/api/getUserDetails", authToken: UserDefaults.standard.string(forKey: "authToken") ?? "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjI5LCJuYW1lIjoia2FyYW4iLCJleHAiOjE3MTk2NDc1OTJ9.S8BPM40qw4KDeC-dK59VZtFr78ae1SkBzxjA2veaGU8") { [self] (success: Bool, response: Userdata?) in
            if success {
                if let responseData = response {
                    userData = response
                } else {
                    print("data ni aaya user ka")
                }
            }
        }
    }
}
