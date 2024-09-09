//
//  DetailTableViewCell.swift
//  Doctor
//
//  Created by Minh Nguỵn on 27/8/24.
//

import UIKit
import Nuke
class DetailTableViewCell: UITableViewCell {
    
    @IBOutlet var markButton: UIButton!
    @IBOutlet var detailCreatedLabel: UILabel!
    @IBOutlet var detailTitleLabel: UILabel!
    @IBOutlet var detailImageView: UIImageView!
    
    var isCheck = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        detailImageView.layer.cornerRadius = 8
//        markButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        markButton.transform = CGAffineTransform(scaleX: 0.8, y: 0.65) // Thu nhỏ 20%
        markButton.tintColor = UIColor(red: 150/255, green: 155/255, blue: 171/255, alpha: 1)
    }
    public func articleConfigure(with article: NewsItem) {
        detailTitleLabel.text = article.title
        detailCreatedLabel.text = article.createdAt
        if let imageUrl = URL(string: article.picture) {
            Nuke.loadImage(with: imageUrl, into: detailImageView) {
                result in
                switch result {
                case .success(let response):
                    print("Image loaded successfully: \(response.image)")
                case .failure(let error):
                    print("Error loading image: \(error.localizedDescription)")
                    self.detailImageView.image = UIImage(named: "default")
                }
            }
        }
        
    }
    public func promotionConfigure(with listPromotion: Item) {
        detailTitleLabel.text = listPromotion.name
        detailCreatedLabel.text = listPromotion.createdAt
        if let imageUrl = URL(string: listPromotion.picture ?? "") {
            Nuke.loadImage(with: imageUrl, into: detailImageView) {
                result in
                switch result {
                case .success(let response):
                    print("Image loaded successfully: \(response.image)")
                case .failure(let error):
                    print("Error loading image: \(error.localizedDescription)")
                    self.detailImageView.image = UIImage(named: "default")
                }
            }
        }
        
    }
    
    @IBAction func didTapMarked(_ sender: Any) {
        if !isCheck {
            markButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
            markButton.tintColor = UIColor(red: 44/255, green: 134/255, blue: 103/255, alpha: 1)
        }
        else {
            markButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
            markButton.tintColor = UIColor(red: 150/255, green: 155/255, blue: 171/255, alpha: 1)
        }
        isCheck.toggle()
    }
}
