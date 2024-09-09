//
//  ArticleTableViewCell.swift
//  Doctor
//
//  Created by Minh Nguỵn on 22/8/24.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var viewCollection: UIView!
    @IBOutlet private weak var newLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    weak var delegate: ArticleTableViewCellDelegate?
    
    var articles = [Article]()
    var homeData: HomeData?
    var articleViewModel: ArticleViewModel?
    let homeService = HomeService()
    var numberOfArticles = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "ArticleCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ArticleCollectionViewCell")
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        collectionView.collectionViewLayout.invalidateLayout()
        viewCollection.layer.cornerRadius = 50
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func fetchData() {
        NewsService.fetchNews { result in
            switch result {
            case .success(let data):
                self.articles = data.articleList
                if self.articleViewModel == nil {
                    self.articleViewModel = ArticleViewModel()
                }
                self.homeData = data
                self.articleViewModel?.articles = data.articleList
                print(data.articleList)
                self.numberOfArticles = data.articleList.count
                print(self.articles)
                self.updateUI()
            case .failure(let error):
                print("Error fetching news: \(error)")
            }
        }
        print("Articles count: \(self.articles.count)")
    }
    
    
    func updateUI() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    @IBAction func seeDidtapped(_ sender: Any) {
        delegate?.didTapSeeAllArticles()
    }
}

// MARK: - UICollectionViewDataSource
extension ArticleTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArticleCollectionViewCell", for: indexPath) as! ArticleCollectionViewCell
        let article = articles[indexPath.item]
        // Cấu hình cell với dữ liệu từ `article`
        cell.configure(with: article)
        cell.layer.cornerRadius = 10  // Bo góc
        cell.layer.borderWidth = 1    // Độ rộng của khung
        cell.layer.borderColor = UIColor.systemGray.withAlphaComponent(0.2).cgColor  // Màu của khung
        cell.articleImageView.clipsToBounds = true
    //    applyShadow(to: cell)
        cell.createdLabel.textColor = UIColor(red: 150/255, green: 155/255, blue: 171/255, alpha: 1)
        return cell
    }
}
// MARK: - UICollectionViewDelegate
extension ArticleTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let article = articles[indexPath.item]
        // Gửi thông tin URL qua delegate
        delegate?.didTapArticle(with: article.link)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension ArticleTableViewCell: UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = collectionView.frame.width * 0.7 // Đặt chiều rộng là 60% chiều rộng của collectionView
            let height = collectionView.frame.height // Sử dụng chiều cao của collectionView để điều chỉnh cell
            return CGSize(width: width, height: height)
        }
    

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        // Thiết lập kích thước cho cell
//        return CGSize(width: 258, height: 220)
//    }
    
//        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//            return 16  // Khoảng cách giữa các dòng
//        }
//    
//        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//            return 16  // Khoảng cách giữa các cell trong cùng một dòng
//        }
//    
//        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//            // Thiết lập khoảng cách giữa các section
//            return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
//        }
}


