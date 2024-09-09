//
//  HeaderTableViewCell.swift
//  Doctor
//
//  Created by Minh Nguỵn on 27/8/24.
//

import UIKit
import Nuke

class HeaderTableViewCell: UITableViewCell {
    @IBOutlet private weak var headerCreateLabel: UILabel!
    @IBOutlet private weak var headerTitleLabel: UILabel!
    @IBOutlet private weak var headerImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func configure(with article: NewsItem) {
        headerTitleLabel.text = article.title
        headerCreateLabel.text = article.createdAt
        if let imageUrl = URL(string: article.picture) {
            Nuke.loadImage(with: imageUrl, into: headerImageView) {
                result in
                switch result {
                case .success(let response):
                    print("Image loaded successfully: \(response.image)")
                case .failure(let error):
                    print("Error loading image: \(error.localizedDescription)")
                    self.headerImageView.image = UIImage(named: "default")
                }
            }
        }
        
    }
}
