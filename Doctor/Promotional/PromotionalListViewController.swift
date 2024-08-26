import UIKit

class PromotionalListViewController: UIViewController , UITableViewDelegate {
    @IBOutlet private weak var tableView: UITableView!
    
    private let promotionalViewModel = PromotionalViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "PromotionalListTableViewCell", bundle: nil), forCellReuseIdentifier: "PromotionalListTableViewCell")
        navigationItem.hidesBackButton = true
        // Fetch data and reload tableView
            promotionalViewModel.fetchPromotionalItems()
            promotionalViewModel.onDataFetched = { [weak self] in
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
// MARK: - UITableViewDataSource
extension PromotionalListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return promotionalViewModel.promotionalItems.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PromotionalListTableViewCell", for: indexPath) as! PromotionalListTableViewCell
        // Lấy dữ liệu từ ViewModel
        let promotionalItem = promotionalViewModel.promotionalItems[indexPath.row]
        // Cấu hình cell với dữ liệu từ PromotionalItem
        cell.configure(with: promotionalItem)
        return cell
    }

}


