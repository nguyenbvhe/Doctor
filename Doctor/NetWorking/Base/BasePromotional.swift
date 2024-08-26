//
//  BasePromotional.swift
//  Doctor
//
//  Created by Minh Nguỵn on 26/8/24.
//

import Foundation
import Alamofire

// MARK: - Base Service Class
class BaseServicePromotional {
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

// MARK: - Base Promotional Service Class
class BasePromotional: BaseServicePromotional {
    let newURL = "https://gist.githubusercontent.com/CanThaiLinh/a373bfb717cb25a5fa4a1017995847eb/raw"
    
    func fetchPromotionalItems(success: @escaping (PromotionalResponse) -> Void, failure: @escaping (_ code: Int, _ message: String) -> Void) {
        BaseServicePromotional.request(url: newURL, responseType: PromotionalResponse.self) { result in
            switch result {
            case .success(let response):
                success(response)
                print(response.listTtems?.count ?? 0)
            case .failure(let error):
                failure(error.responseCode ?? 0, error.localizedDescription)
                print("ERROR \(error.responseCode ?? 0): \(error.localizedDescription)")
            }
        }
    }
}

// MARK: - Promotional Service
class PromotionalService: BasePromotional {
    static func fetchPromotional(completion: @escaping (Result<PromotionalResponse?, AFError>) -> Void) {
        let url = "https://gist.githubusercontent.com/CanThaiLinh/a373bfb717cb25a5fa4a1017995847eb/raw"
        BaseServicePromotional.request(url: url, responseType: APIPromotional.self) { result in
            switch result {
            case .success(let newsResponse):
                completion(.success(newsResponse.data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
