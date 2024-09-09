//
//  DoctorCollectionViewCell.swift
//  BSGNProject
//
//  Created by Linh Thai on 21/08/2024.
//

import UIKit
import Nuke
class DoctorCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var reviewerCountLabel: UILabel!
    @IBOutlet weak var starLabel: UILabel!
    @IBOutlet weak var majorNameLabel: UILabel!
    @IBOutlet weak var doctorNameLabel: UILabel!
    @IBOutlet weak var doctorImageVIew: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        doctorImageVIew.layer.cornerRadius = 10
        doctorImageVIew.clipsToBounds = true
        doctorImageVIew.contentMode = .scaleAspectFill
        
    }
    public func configure(with doctor: Doctor) {
        if let imageUrl = URL(string: doctor.avatar) {
            Nuke.loadImage(with: imageUrl, into: doctorImageVIew) {
                result in
                switch result {
                case .success(let response):
                    print("Image loaded successfully: \(response.image)")
                case .failure(let error):
                    print("Error loading image: \(error.localizedDescription)")
                    self.doctorImageVIew.image = UIImage(named: "img_doctor")
                }
            }
        }
    }
    
    
}
