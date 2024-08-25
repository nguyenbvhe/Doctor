//
//  ArticleViewModel.swift
//  BSGNProject
//
//  Created by Linh Thai on 16/08/2024.
//

import Foundation
import UIKit

class ArticleViewModel {
    var articles: [ArticleList] = []
    
    var articleImages: [Int: UIImage] = [:]
    let homeService = HomeService()
    var count: Int {
        
        return articles.count
    }

    func article(at index: Int) -> ArticleList {
        return articles[index]
    }
//    init(articles: [Article], errorMessage: String? = nil, articleImages: [Int : UIImage]) {
//        self.articles = articles
//        self.articleImages = articleImages
//    }
    private func loadArticleImages() {
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
    func homeConfigure(with index: IndexPath) -> (title: String, created_at: String, image: UIImage?) {
        return (articles[index.row].title, articles[index.row].createdAt, articleImages[articles[index.row].id])
    }
     func fetchArticles(success: @escaping () -> Void, failure: @escaping (_ code: Int, _ message: String) -> Void) {
         NewsService.fetchNews{
             result in
                 switch result {
                 case .success(let data):
                     self.articles = data.articleList
                 case .failure(let error):
                     print("000000000000000000000000\(error)")
                 }
         }
         
     }
    func reloadData(success: @escaping () -> Void, failure: @escaping (_ code: Int, _ message: String) -> Void) {
            fetchArticles(success: {
                // Notify the view controller to reload UI (e.g., reload a table view)
                success()
            }, failure: { code, message in
                // Handle failure
                failure(code, message)
            })
    }
}
