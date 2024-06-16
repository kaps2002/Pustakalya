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
    
    func signupRequest(from url: String, parameters: Parameters?, completion: @escaping(Bool) -> Void) {
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseData { response in
            if let statusCode = response.response?.statusCode {
                if (400...599).contains(statusCode) {
                    completion(false)
                } else {
                    completion(true)
                }
            }
        }
    }
}
