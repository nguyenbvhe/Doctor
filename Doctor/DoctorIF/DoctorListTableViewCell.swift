import UIKit
import Nuke

class DoctorListTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var starLabel: UILabel!
    @IBOutlet private weak var reviewerLabel: UILabel!
    @IBOutlet private weak var doctorMajorlabel: UILabel!
    @IBOutlet private weak var doctorNameLabel: UILabel!
    @IBOutlet private weak var doctorImage: UIImageView!
    @IBOutlet private weak var viewCell: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    func setupUI() {
        doctorImage.layer.cornerRadius = 10
        doctorImage.clipsToBounds = true
        doctorImage.contentMode = .scaleAspectFill
        viewCell.layer.cornerRadius = 12  // Bo góc
        viewCell.layer.borderWidth = 1    // Độ rộng của khung
        viewCell.layer.borderColor = UIColor.systemGray.withAlphaComponent(0.3).cgColor  // Màu của khung
    }
    
    public func doctorConfigure(with doctor: DoctorItem) {
        doctorNameLabel.text = doctor.fullName
        doctorMajorlabel.text = "Chuyên ngành: \(doctor.majorsName ?? "")"
        starLabel.text = "\(doctor.ratioStar ?? 0.0)"
        reviewerLabel.text = "\(doctor.numberOfReviews ?? 0) Reviews"
        
        doctorImage.image = UIImage(named: "img_doctor") // Reset image before loading
        
        if let imageUrl = URL(string: doctor.avatar ?? "") {
            Nuke.loadImage(with: imageUrl, into: doctorImage) { result in
                switch result {
                case .success(let response):
                    print("Image loaded successfully: \(response.image)")
                case .failure(let error):
                    print("Error loading image: \(error.localizedDescription)")
                    self.doctorImage.image = UIImage(named: "img_doctor")
                }
            }
        }
    }
    
}
