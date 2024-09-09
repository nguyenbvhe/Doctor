import UIKit

class PromotionListViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = PromotionViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "DetailTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailTableViewCell")
        
        setupViewModel()
        viewModel.fetchPromotionalItems()
        setupUI()
    }
    
    private func setupViewModel() {
        viewModel.onDataFetched = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        viewModel.onError = { errorMessage in
            print("Error: \(errorMessage)")
            // Bạn có thể hiển thị alert hoặc thông báo lỗi ở đây.
        }
    }
    func setupUI() {
        backButton.layer.cornerRadius = backButton.frame.size.width/2
        backButton.layer.borderWidth = 1
        backButton.layer.borderColor = UIColor.systemGray3.cgColor
    }
    
    
    @IBAction func popDidTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}

extension PromotionListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.listPromotion.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailTableViewCell", for: indexPath) as! DetailTableViewCell
        let promotion = viewModel.listPromotion[indexPath.row]
        cell.promotionConfigure(with: promotion)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension PromotionListViewController: UITableViewDelegate {
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        let vc = NewDetailViewController()
    //        self.navigationController?.pushViewController(vc, animated: true)
    //    }
}
