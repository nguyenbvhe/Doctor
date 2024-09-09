//
//  BaseUser.swift
//  Doctor
//
//  Created by Minh Nguyễn on 29/8/24.
//

import Foundation
import Alamofire

// Base Service Class
class BaseUserService {
    
    // Generic request function for any type of response
    static func request<T: Decodable>(url: String, responseType: T.Type, success: @escaping (T) -> Void, failure: @escaping (_ code: Int, _ message: String) -> Void) {
        AF.request(url).responseDecodable(of: responseType) { response in
            switch response.result {
            case .success(let data):
                success(data)
            case .failure(let error):
                let statusCode = response.response?.statusCode ?? -1
                failure(statusCode, error.localizedDescription)
            }
        }
    }
}

// User Service Class
class UserService: BaseUserService {
    static func fetchUserNews(completion: @escaping (Result<UserInfoResponse, AFError>) -> Void) {
        let url = "https://gist.github.com/CanThaiLinh/00762adf68d2dddf0aea6396fd1b153a/raw"
        BaseUserService.request(url: url, responseType: UserInfoResponse.self, success: { response in
            print("Data fetched successfully: \(response)")
            completion(.success(response))
        }, failure: { code, message in
            print("Failed to fetch data with error: \(message)")
            completion(.failure(AFError.explicitlyCancelled))
        })
    }
}

// NewsUserService Class
class NewsUserService: UserService {
    let userURL = "https://gist.github.com/CanThaiLinh/00762adf68d2dddf0aea6396fd1b153a/raw"
    
    func fetchUserData(success: @escaping (UserInfoResponse) -> Void, failure: @escaping (_ code: Int, _ message: String) -> Void) {
        NewsUserService.request(url: userURL, responseType: UserInfoResponse.self, success: { response in
            success(response)
            if let data = response.data {
                print("Fetched user data successfully.")
            } else {
                print("No user data found.")
            }
        }, failure: { code, message in
            failure(code, message)
            print("ERROR \(code): \(message)")
        })
    }
}
