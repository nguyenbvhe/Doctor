import Foundation
import Alamofire
class HomeService: BaseService3 {
    let homeURL = "https://gist.githubusercontent.com/hdhuy179/f967ffb777610529b678f0d5c823352a/raw"
    func fetchHomeData(success: @escaping (HomeData) -> Void, failure: @escaping (_ code: Int, _ message: String) -> Void) {
        request(homeURL, .get, of: HomeData.self, success: { response in
            success(response)
            print(response.articleList.count)
        }, failure: { code, message in
            failure(code, message)
            print("ERROR \(code): \(message)")
        })
    }
}

class NewsService: BaseService {
    static func fetchNews(completion: @escaping (Result<HomeData, AFError>) -> Void) {
        let url = "https://gist.githubusercontent.com/hdhuy179/f967ffb777610529b678f0d5c823352a/raw"
        request(url: url, responseType: APINewResponse.self) { result in
            switch result {
            case .success(let newsResponse):
                completion(.success(newsResponse.data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

class BaseService {
    // Phương thức để gửi yêu cầu và xử lý phản hồi JSON
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


