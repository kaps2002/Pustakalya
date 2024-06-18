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
    
    func request<T: Decodable> (from url: String, method: HTTPMethod = .post, parameters: Parameters?, completion: @escaping (Bool, T?) -> Void) {
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let apiData = try JSONDecoder().decode(T.self, from: data)
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
    
    func signupRequest(from url: String, parameters: Parameters?, completion: @escaping(Bool, SignUpModelData?) -> Void) {
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let apiData = try JSONDecoder().decode(SignUpModelData.self, from: data)
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
    
    func verifyEmail(from url: String, method: HTTPMethod = .post, _ authToken: String, parameters: Parameters?, completion: @escaping (Bool) -> Void) {
        AF.request(url, method: .post, parameters: parameters, headers: ["Authorization": "Bearer \(authToken)"]).responseData { response in
            if let statusCode = response.response?.statusCode {
                print(statusCode)
                if (400...599).contains(statusCode) {
                    completion(false)
                }
                else {
                    completion(true)
                }
            }
        }
    }
    
    func fetchBooks(from url: String, completion: @escaping (Bool, BooksData?) -> Void) {
        AF.request(url, method: .get, encoding: JSONEncoding.default).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let apiData = try JSONDecoder().decode(BooksData.self, from: data)
                    completion(true, apiData)
                } catch {
                    print(1, error)
                    completion(false, nil)
                }
            case .failure(let error):
                print(2, error)
                completion(false, nil)
            }
        }
    }
}
