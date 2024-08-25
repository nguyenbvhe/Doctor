//
//  ArticleCollectionViewCell.swift
//  BSGNProject
//
//  Created by Linh Thai on 16/08/2024.
//

import UIKit
import SDWebImage
import Nuke



class ArticleCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var createdLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!
  
    override func awakeFromNib() {
        super.awakeFromNib()
    }
  
    public func configure(with article: ArticleList) {
        if let imageUrl = URL(string: article.picture) {
            Nuke.loadImage(with: imageUrl, into: articleImageView) {
                result in
                switch result {
                case .success(let response):
                    print("Image loaded successfully: \(response.image)")
                case .failure(let error):
                    print("Error loading image: \(error.localizedDescription)")
                    self.articleImageView.image = UIImage(named: "default")
                }
            }
        }
    }
    public func configurePromotion(with promotion: PromotionList) {
        if let imageUrl = URL(string: promotion.picture) {
            Nuke.loadImage(with: imageUrl, into: articleImageView) {
                result in
                switch result {
                case .success(let response):
                    print("Image loaded successfully: \(response.image)")
                case .failure(let error):
                    print("Error loading image: \(error.localizedDescription)")
                    self.articleImageView.image = UIImage(named: "default")
                }
            }
        }
    }
    
    
}
