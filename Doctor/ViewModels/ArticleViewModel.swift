import Foundation
import UIKit

class ArticleViewModel {
    var articles: [Article] = []
    var articleImages: [Int: UIImage] = [:]
    var listArticles: [NewsItem] = []
    var onDataFetched: (() -> Void)?
    var onError: ((String) -> Void)?
    let homeService = HomeService()
    
    private func loadNewsItemImages() {
        for article in articles {
            guard let url = URL(string: article.picture) else { continue }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil, let image = UIImage(data: data) else {
                    return
                }
                DispatchQueue.main.async {
                    self.articleImages[article.id] = image
                }
            }.resume()
        }
    }
    
    
    func fetchNewsItems() {
        NewsItemService().fetchNewsItemData(success: { [weak self] response in
            self?.listArticles = response.data?.items ?? []
            self?.onDataFetched?()
        }, failure: { [weak self] code, message in
            self?.onError?(message)
        })
    }
}





