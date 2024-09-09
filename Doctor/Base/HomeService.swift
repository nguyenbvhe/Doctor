import Foundation
import Alamofire

// MARK: - BaseUseScreenHome
class HomeService: BaseSevice2 {
    let homeURL = "https://gist.githubusercontent.com/hdhuy179/f967ffb777610529b678f0d5c823352a/raw"
    func fetchHomeData(success: @escaping (HomeData) -> Void, failure: @escaping (_ code: Int, _ message: String) -> Void) {
        HomeService.request(url: homeURL, method: .get, responseType: HomeData.self, success: { response in
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
        request(url: url, responseType: APIModel.self) { result in
            switch result {
            case .success(let newsResponse):
                completion(.success(newsResponse.data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
