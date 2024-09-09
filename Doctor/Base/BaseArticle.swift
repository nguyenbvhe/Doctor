import Foundation
import Alamofire

// Service Class
class NewsItemService: ItemService {
    let newsItemURL = "https://gist.githubusercontent.com/CanThaiLinh/54afd6bc6efe3098f4480bf19a3739d2/raw"
    
    func fetchNewsItemData(success: @escaping (NewsResponse) -> Void, failure: @escaping (_ code: Int, _ message: String) -> Void) {
        NewsItemService.request(url: newsItemURL, responseType: NewsResponse.self, success: { response in
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

class ItemService: BaseSevice2 {
    static func fetchPromotionNews(completion: @escaping (Result<PromotionNewResponse, AFError>) -> Void) {
        let url = "https://gist.githubusercontent.com/CanThaiLinh/54afd6bc6efe3098f4480bf19a3739d2/raw"
        BaseSevice2.request(url: url, responseType: PromotionNewResponse.self, success: { response in
            print("Data fetched successfully: \(response)")
            completion(.success(response))
        }, failure: { code, message in
            print("Failed to fetch data with error: \(message)")
            completion(.failure(AFError.explicitlyCancelled))
        })
    }
}
