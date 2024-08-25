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

class HomeViewController: UIViewController, ArticleTableViewCellDelegate {
   
   
    @IBOutlet private weak var tableView: UITableView!
    
    // Mảng chứa các loại cell sẽ được hiển thị
    private let cells: [typeHome] = [.new, .promotion, .doctor]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "ArticleTableViewCell", bundle: nil), forCellReuseIdentifier: "ArticleTableViewCell")
        tableView.register(UINib(nibName: "PromotionTableViewCell", bundle: nil), forCellReuseIdentifier: "PromotionTableViewCell")
        tableView.register(UINib(nibName: "DoctorTableViewCell", bundle: nil), forCellReuseIdentifier: "DoctorTableViewCell")
        tableView.layer.cornerRadius = 16
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
            applyShadow(to: cell) // Áp dụng đổ bóng cho cell
            cell.layoutIfNeeded() // Đảm bảo layout đã được cập nhật
            cell.fetchData()
            cell.delegate = self
            return cell
            
        case .promotion:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PromotionTableViewCell", for: indexPath) as! PromotionTableViewCell
            applyShadow(to: cell) // Áp dụng đổ bóng cho cell
            cell.layoutIfNeeded() // Đảm bảo layout đã được cập nhật
            return cell
            
        case .doctor:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DoctorTableViewCell", for: indexPath) as! DoctorTableViewCell
            applyShadow(to: cell) // Áp dụng đổ bóng cho cell
            cell.layoutIfNeeded() // Đảm bảo layout đã được cập nhật
            cell.fetchData()
            return cell
        }
    }
}

    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
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
