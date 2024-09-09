//
//  BaseService2.swift
//  Doctor
//
//  Created by Minh Nguỵn on 27/8/24.
//

import Foundation
import Alamofire

class BaseService {
    // Phương thức chung để thực hiện request với Alamofire
    static func request<T: Decodable>(url: String, responseType: T.Type, completion: @escaping (Result<T, AFError>) -> Void) {
        AF.request(url).validate().responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                // In ra lỗi chi tiết để dễ dàng gỡ lỗi
                print("Error fetching data: \(error.localizedDescription)")
                if let underlyingError = error.underlyingError {
                    print("Underlying error: \(underlyingError)")
                }
                if let data = response.data {
                    print("Response data: \(String(data: data, encoding: .utf8) ?? "No data")")
                }
                completion(.failure(error))
            }
        }
    }
}

class BaseSevice2 {
    static func request<T: Decodable>(url: String, method: HTTPMethod = .get, responseType: T.Type, success: @escaping (T) -> Void, failure: @escaping (_ code: Int, _ message: String) -> Void) {
        AF.request(url, method: method).validate().responseDecodable(of: responseType) { response in
            switch response.result {
            case .success(let data):
                success(data)
            case .failure(let error):
                print("Request failed with error: \(error.localizedDescription)")
                failure(response.response?.statusCode ?? 0, error.localizedDescription)
            }
        }
    }
    
}

