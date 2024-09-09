import Foundation
import Alamofire

class PromotionService: BaseSevice2 {
    let promotionURL = "https://gist.github.com/CanThaiLinh/a373bfb717cb25a5fa4a1017995847eb/raw"
    
    func fetchPromotionData(success: @escaping (PromotionNewResponse) -> Void, failure: @escaping (_ code: Int, _ message: String) -> Void) {
        BaseSevice2.request(url: promotionURL, responseType: PromotionNewResponse.self, success: { response in
            success(response)
            if let items = response.data?.items {
                print("Fetched \(items.count) items.")
            } else {
                print("No items found.")
            }
        }, failure: { code, message in
            failure(code, message)
            print("ERROR \(code): \(message)")
        })
    }
}


class PromotionNewsService: BaseSevice2 {
    static func fetchPromotionNews(completion: @escaping (Result<PromotionNewResponse, AFError>) -> Void) {
        let url = "https://gist.github.com/CanThaiLinh/a373bfb717cb25a5fa4a1017995847eb/raw"
        BaseSevice2.request(url: url, responseType: PromotionNewResponse.self, success: { response in
            print("Data fetched successfully: \(response)")
            completion(.success(response))
        }, failure: { code, message in
            print("Failed to fetch data with error: \(message)")
            completion(.failure(AFError.explicitlyCancelled))
        })
    }
}
