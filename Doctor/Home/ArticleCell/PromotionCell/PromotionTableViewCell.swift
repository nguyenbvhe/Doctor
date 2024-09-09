//
//  PromotionTableViewCell.swift
//  BSGNProject
//
//  Created by Linh Thai on 16/08/2024.
//

import UIKit
class PromotionTableViewCell: UITableViewCell {
    
    @IBOutlet var promoTionCollectionView: UICollectionView!
    var promotions = [Promotion]()
    var homeData: HomeData?
    var promotionViewModel: PromotionViewModel?
    var numberOfPromotion = 0
    weak var delegate: PromotionTableViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
        fetchData()
    }
    
    @IBAction func seeAllTapped(_ sender: UIButton) {
        delegate?.didTapSeeAllPromotions()
    }
    
    // MARK: - Setup CollectionView
    private func setupCollectionView() {
        promoTionCollectionView.delegate = self
        promoTionCollectionView.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        promoTionCollectionView.collectionViewLayout = layout
        promoTionCollectionView.register(UINib(nibName: "ArticleCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ArticleCollectionViewCell")
    }
    
    // MARK: - Fetch Data
    func fetchData() {
        NewsService.fetchNews { result in
            switch result {
            case .success(let data):
                self.promotions = data.promotionList
                if self.promotionViewModel == nil {
                    self.promotionViewModel = PromotionViewModel()
                }
                self.homeData = data
                self.promotionViewModel?.promotions = data.promotionList
                self.numberOfPromotion = data.promotionList.count
                self.updateUI()
            case .failure(let error):
                print("Error fetching promotions: \(error)")
            }
        }
    }
    
    // MARK: - Update UI
    func updateUI() {
        DispatchQueue.main.async {
            self.promoTionCollectionView.reloadData()
        }
    }
    
    // MARK: - Helper Method to Apply Shadow
    private func applyShadow(to cell: UICollectionViewCell) {
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 2)
        cell.layer.shadowOpacity = 0.3
        cell.layer.shadowRadius = 4
        cell.layer.masksToBounds = false
    }
}

// MARK: - UICollectionViewDataSource
extension PromotionTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfPromotion
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArticleCollectionViewCell", for: indexPath) as? ArticleCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if let promotion = promotionViewModel?.promotions[indexPath.row] {
            cell.configurePromotion(with: promotion)
            cell.titleLabel.text = promotion.name
            cell.createdLabel.text = promotion.createdAt
        }
        cell.layer.cornerRadius = 10  // Bo góc
        cell.layer.borderWidth = 1    // Độ rộng của khung
        cell.layer.borderColor = UIColor.systemGray.withAlphaComponent(0.2).cgColor  // Màu của khung
        cell.layer.masksToBounds = true // Đảm bảo rằng các góc của cell được bo sẽ không lộ ra
        cell.articleImageView.clipsToBounds = true
        applyShadow(to: cell)
        cell.createdLabel.textColor = UIColor(red: 150/255, green: 155/255, blue: 171/255, alpha: 1)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension PromotionTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let promotion = promotions[indexPath.item]
        
        // Gửi thông tin URL qua delegate hoặc notification
        NotificationCenter.default.post(name: Notification.Name("PromotionSelected"), object: promotion.link)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension PromotionTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width * 0.7 // Đặt chiều rộng là 70% chiều rộng của collectionView
        let height = collectionView.frame.height // Sử dụng chiều cao của collectionView để điều chỉnh cell
        return CGSize(width: width, height: height)
    }
}
