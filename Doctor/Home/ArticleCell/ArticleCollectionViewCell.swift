import UIKit
import SDWebImage
import Nuke

class ArticleCollectionViewCell: UICollectionViewCell , SummaryMethod {
    
    @IBOutlet private weak var cycleView: UIView!
    @IBOutlet weak var createdLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet private weak var endowLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        cycleView.layer.cornerRadius = cycleView.frame.size.width/2
        endowLabel.textColor = BaseColor.primaryColor
        createdLabel.textColor = UIColor.gray.withAlphaComponent(0.7)
        
        articleImageView.layer.cornerRadius = 10
        articleImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] // Bo góc trên trái và phải
        articleImageView.clipsToBounds = true // Đảm bảo rằng phần ảnh nằm ngoài vùng bo góc sẽ bị cắt
        self.layer.masksToBounds = true
        
    }
    
    // Cấu hình cell với dữ liệu từ article
    public func configure(with article: Article) {
        titleLabel.text = article.title
        createdLabel.text = article.createdAt
        loadImage(from: article.picture)
    }
    
    // Cấu hình cell với dữ liệu từ promotion
    public func configurePromotion(with promotion: Promotion) {
        titleLabel.text = promotion.name
        createdLabel.text = promotion.createdAt
        loadImage(from: promotion.picture)
    }
    
    // Phương thức tải ảnh từ URL
    private func loadImage(from urlString: String?) {
        guard let urlString = urlString, let imageUrl = URL(string: urlString) else {
            articleImageView.image = UIImage(named: "default")
            return
        }
        Nuke.loadImage(with: imageUrl, into: articleImageView) { [weak self] result in
            switch result {
            case .success(let response):
                print("Image loaded successfully: \(response.image)")
            case .failure(let error):
                print("Error loading image: \(error.localizedDescription)")
                self?.articleImageView.image = UIImage(named: "default")
            }
        }
    }
}
