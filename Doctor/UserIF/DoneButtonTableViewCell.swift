//
//  DoneButtonTableViewCell.swift
//  Doctor
//
//  Created by Minh Nguỵn on 29/8/24.
//

import UIKit

class DoneButtonTableViewCell: UITableViewCell {

    @IBOutlet private weak var doneButton: UIButton!
    weak var delegate: DoneButtonTableViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        doneButton.layer.cornerRadius = 24
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func doneDidtapped(_ sender: Any) {
        delegate?.popDidTapped()
    }
}
