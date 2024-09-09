//
//  HomeViewController.swift
//  Doctor
//
//  Created by Minh Nguỵn on 22/8/24.
//

import UIKit

enum typeHome {
    case new , promotion , doctor
}

class HomeViewController: UIViewController {
    @IBOutlet private weak var informationButton: UIButton!
    @IBOutlet weak var onlineStatusView: UIView!
    @IBOutlet private weak var tableView: UITableView!
    
    // Mảng chứa các loại cell sẽ được hiển thị
    private let cells: [typeHome] = [.new, .promotion, .doctor]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupUI()
        navigationController?.isNavigationBarHidden = true
    }
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "ArticleTableViewCell", bundle: nil), forCellReuseIdentifier: "ArticleTableViewCell")
        tableView.register(UINib(nibName: "PromotionTableViewCell", bundle: nil), forCellReuseIdentifier: "PromotionTableViewCell")
        tableView.register(UINib(nibName: "DoctorTableViewCell", bundle: nil), forCellReuseIdentifier: "DoctorTableViewCell")
    }
    func setupUI() {
        tableView.layer.cornerRadius = 16
        informationButton.layer.cornerRadius = informationButton.frame.size.width/2
        informationButton.layer.masksToBounds = true
        informationButton.setImage(UIImage(named: "default"), for: .normal)
        onlineStatusView.layer.cornerRadius = onlineStatusView.frame.size.width/2
    }
    @IBAction func selectUserDidTapped(_ sender: Any) {
        let vc = UserInformationViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    // MARK: - Helper Method to Apply Shadow
    func applyShadow(to cell: UITableViewCell) {
            cell.layer.shadowColor = UIColor.black.cgColor
            cell.layer.shadowOffset = CGSize(width: 0, height: 2)
            cell.layer.shadowRadius = 4
            cell.layer.shadowOpacity = 0.2
            cell.layer.masksToBounds = false
            cell.layer.cornerRadius = 8
        }
        
    // MARK: - ArticleTableViewCellDelegate
    func didTapArticle(with link: String) {
        // Điều hướng sang PromotionalListViewController
        let vc = NewDetailViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = cells[indexPath.row]
        
        switch cellType {
        case .new:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as! ArticleTableViewCell
            // applyShadow(to: cell) // Áp dụng đổ bóng cho cell
            cell.layoutIfNeeded() // Đảm bảo layout đã được cập nhật
            cell.fetchData()
            cell.delegate = self
            return cell
            
        case .promotion:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PromotionTableViewCell", for: indexPath) as! PromotionTableViewCell
      //      applyShadow(to: cell) // Áp dụng đổ bóng cho cell
            cell.layoutIfNeeded() // Đảm bảo layout đã được cập nhật
            cell.delegate = self  // Gán delegate cho cell
            return cell
            
        case .doctor:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DoctorTableViewCell", for: indexPath) as! DoctorTableViewCell
      //      applyShadow(to: cell) // Áp dụng đổ bóng cho cell
            cell.layoutIfNeeded() // Đảm bảo layout đã được cập nhật
            cell.delegate = self
            cell.fetchData()
            return cell
        }
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch cells[indexPath.row] {
        case .doctor:
            return 223
        default:
            return 258
        }
    }
}
extension HomeViewController: PromotionTableViewCellDelegate{
    func didTapSeeAllPromotions() {
        let promotionVC = PromotionListViewController()
        navigationController?.isNavigationBarHidden = true
        self.navigationController?.pushViewController(promotionVC, animated: true)
    }
}
extension HomeViewController: ArticleTableViewCellDelegate {
    func didTapSeeAllArticles() {
        let vc = ArticleListViewController()
        navigationController?.isNavigationBarHidden = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

extension HomeViewController: DoctorTableViewCellDelegate {
    func didTapSeeAllDoctors() {
        let vc = DoctorListViewController()
        navigationController?.isNavigationBarHidden = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

