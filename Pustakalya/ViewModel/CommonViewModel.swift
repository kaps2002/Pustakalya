//
//  CommonViewModel.swift
//  Pustakalya
//
//  Created by Roro on 17/06/24.
//

import Foundation
import Alamofire
import UIKit
@Observable
class CommonViewModel {
    var isAlert = false
    var booksData: BooksData?
    
    func checkInternet(completion: @escaping (Bool) -> Void) {
        let reachabilityManager = NetworkReachabilityManager()
        reachabilityManager?.startListening(onQueue: .main) { status in
            let isInternetConnected = status == .reachable(.ethernetOrWiFi) || status == .reachable(.cellular)
            completion(isInternetConnected)
        }
    }
    func settingsOpener() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    func fetchBooks() {
        APIManager.shared.fetchBooks(from: "https://pustakalya.vercel.app/api/getBooks") { [self] (success: Bool, response: BooksData?) in
            if success {
                // Handle successful response
                if let responseData = response {
                    booksData = responseData
                    print(booksData ?? "hello")
                }
            } else {
                print("data nhi aaya")
            }
        }
    }
}
