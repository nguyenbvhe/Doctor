//
//  GenderTableViewCell.swift
//  Doctor
//
//  Created by Minh Nguỵn on 29/8/24.
//

import UIKit

class GenderTableViewCell: UITableViewCell {
    @IBOutlet weak var chooseGenderSegmented: UISegmentedControl!
    @IBOutlet weak var genderLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setupUI() {
        // Đặt màu text mặc định cho các mục
            let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        chooseGenderSegmented.setTitleTextAttributes(titleTextAttributes, for: .normal)
                
                // Đặt màu text cho mục được chọn
            let selectedTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 44/255, green: 134/255, blue: 103/255, alpha: 1)]
        chooseGenderSegmented.setTitleTextAttributes(selectedTitleTextAttributes, for: .selected)
        chooseGenderSegmented.selectedSegmentIndex = 1
    }
    
}
