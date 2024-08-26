import UIKit
import SDWebImage
import Nuke
class PromotionalListTableViewCell: UITableViewCell {
    @IBOutlet private weak var promotionalImage: UIImageView!
    @IBOutlet private weak var createdLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    
    private var viewModel: PromotionalViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    
    public func configure(with promotional: PromotionalItem) {
        if let imageUrl = URL(string: promotional.picture ?? "") {
            Nuke.loadImage(with: imageUrl, into: promotionalImage) {
                result in
                switch result {
                case .success(let response):
                    print("Image loaded successfully: \(response.image)")
                case .failure(let error):
                    print("Error loading image: \(error.localizedDescription)")
                    self.promotionalImage.image = UIImage(named: "default")
                }
            }
        } else {
            // Đặt hình ảnh mặc định nếu không có URL
            promotionalImage.image = UIImage(named: "default")
        }
    }
}

