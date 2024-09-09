//
//  UserInformationTableViewCell.swift
//  Doctor
//
//  Created by Minh Nguỵn on 29/8/24.
//

import UIKit

class UserInformationTableViewCell: UITableViewCell , UITextFieldDelegate {
    
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var seperatorView: UIView!
    @IBOutlet weak var seeMoreButton: UIButton!
    @IBOutlet weak var enterTextField: UITextField!
    
    var x: Int = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        DispatchQueue.main.async {
            self.updateXValue()
        }
        return true
    }
    private func updateXValue() {
        if let text = enterTextField.text, !text.isEmpty {
            x = 1
        } else {
            x = 0
        }
        
    }
}
