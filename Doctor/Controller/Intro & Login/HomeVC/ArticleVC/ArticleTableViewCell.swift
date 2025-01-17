//
//  ArticleTableViewCell.swift
//  Doctor
//
//  Created by Minh Nguỵn on 22/8/24.
//

import UIKit
protocol ArticleTableViewCellDelegate: AnyObject {
    func didTapArticle(with link: String)
}
class ArticleTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var newLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    weak var delegate: ArticleTableViewCellDelegate?

    var articles = [ArticleList]()  // Sửa từ `article` thành `articles` cho dễ hiểu
    var homeData: HomeData?
    var articleViewModel: ArticleViewModel?
    let homeService = HomeService()  // Sửa tên biến từ `home` thành `homeService` cho rõ ràng hơn
    var numberOfArticles = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "ArticleCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ArticleCollectionViewCell")
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10  // Điều chỉnh khoảng cách giữa các hàng
        layout.minimumInteritemSpacing = 10  // Điều chỉnh khoảng cách giữa các item trong một hàng
        collectionView.collectionViewLayout = layout
        
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
    
}
// MARK: - bo góc cho view
func roundCorners(corners: UIRectCorner, radius: CGFloat, view: UIView) {
    let path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
    let mask = CAShapeLayer()
    mask.path = path.cgPath
    view.layer.mask = mask
}

func applyCustomRoundedCorners(to cell: UICollectionViewCell) {
    // Bo góc trên trái và trên phải nhiều hơn
    roundCorners(corners: [.topLeft, .topRight], radius: 16, view: cell.contentView)
    
    // Nếu bạn muốn bo góc dưới ít hơn, bạn có thể tùy chỉnh:
    roundCorners(corners: [.bottomLeft, .bottomRight], radius: 8, view: cell.contentView)
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
        cell.layer.cornerRadius = 7  // Bo góc
        cell.layer.borderWidth = 1    // Độ rộng của khung
        cell.layer.borderColor = UIColor.systemGray.withAlphaComponent(0.2).cgColor  // Màu của khung
        // Áp dụng bo góc tùy chỉnh
        applyCustomRoundedCorners(to: cell)
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
        // Thiết lập kích thước cho cell
        return CGSize(width: 258, height: 220)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16  // Khoảng cách giữa các dòng
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16  // Khoảng cách giữa các cell trong cùng một dòng
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // Thiết lập khoảng cách giữa các section
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
}

