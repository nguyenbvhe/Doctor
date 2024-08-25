import Foundation
import Alamofire
class BaseNewDetailService: BaseService3 {
    let newURL = "https://gist.githubusercontent.com/CanThaiLinh/54afd6bc6efe3098f4480bf19a3739d2/raw"
    func fetchNewDetailItems(success: @escaping (NewDetailResponse) -> Void, failure: @escaping (_ code: Int, _ message: String) -> Void) {
        request(newURL, .get, of: NewDetailResponse.self, success: { response in
            success(response)
            print(response.listTtems?.count)
        }, failure: { code, message in
            failure(code, message)
            print("ERROR \(code): \(message)")
        })
    }
}

class NewDetailService: BaseServiceNewsDetail {
    static func fetchNews(completion: @escaping (Result<NewDetailResponse?, AFError>) -> Void) {
        let url = "https://gist.githubusercontent.com/CanThaiLinh/54afd6bc6efe3098f4480bf19a3739d2/raw"
        request(url: url, responseType: APINewDetailResponse.self) { result in
            switch result {
            case .success(let newsResponse):
                completion(.success(newsResponse.data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
class BaseServiceNewsDetail {
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
