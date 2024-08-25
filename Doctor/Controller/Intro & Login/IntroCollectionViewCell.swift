//
//  CollectionViewCell.swift
//  Doctor
//
//  Created by Minh Nguỵn on 14/8/24.
//

import UIKit

class IntroCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var introImage: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subTitleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    func setupData(introLogin: IntroLogin) {
        introImage.image = UIImage(named: introLogin.image)
        titleLabel.text = introLogin.title
        subTitleLabel.text = introLogin.subTitle
    }

}
