//
//  APIManager.swift
//  Pustakalya
//
//  Created by Roro on 16/06/24.
//

import Foundation
import Alamofire

class APIManager {
    static let shared = APIManager()
    
    func request (from url: String, method: HTTPMethod = .post, parameters: Parameters?, completion: @escaping (Bool, AuthModelData?) -> Void) {
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let apiData = try JSONDecoder().decode(AuthModelData.self, from: data)
                    print(apiData)
                    completion(true, apiData)
                } catch {
                    print(error)
                    completion(false, nil)
                }
            case .failure(let error):
                print(error)
                completion(false, nil)
            }
        }
    }
    
    func signupRequest(from url: String, parameters: Parameters?, completion: @escaping(Bool, AuthModelData?) -> Void) {
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let apiData = try JSONDecoder().decode(AuthModelData.self, from: data)
                    completion(true, apiData)
                } catch {
                    print(error)
                    completion(false, nil)
                }
            case .failure(let error):
                print(error)
                completion(false, nil)
            }
        }
    }
    
    func verifyEmail(from url: String, method: HTTPMethod = .post, _ authToken: String, parameters: Parameters?, completion: @escaping (Bool) -> Void) {
        AF.request(url, method: .post, parameters: parameters,encoding: JSONEncoding.default, headers: ["Content-Type": "application/json", "Authorization": "Bearer \(authToken)"]).responseData { response in
            if let statusCode = response.response?.statusCode {
                if (400...599).contains(statusCode) {
                    completion(false)
                }
                else {
                    completion(true)
                }
            }
        }
    }
    
    func fetchBooks(from url: String, authToken: String, completion: @escaping (Bool, BooksData?) -> Void) {
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: ["Content-Type": "application/json", "Authorization": "Bearer \(authToken)"]).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let apiData = try JSONDecoder().decode(BooksData.self, from: data)
                    print(apiData)
                    completion(true, apiData)
                } catch {
                    print(error,1)
                    completion(false, nil)
                }
            case .failure(let error):
                print(error,2)
                completion(false, nil)
            }
        }
    }
    
    func getUser(from url: String, authToken: String, completion: @escaping (Bool, BooksData?) -> Void) {
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: ["Content-Type": "application/json", "Authorization": "Bearer \(authToken)"]).responseData { response in
            
        }
    }
}
