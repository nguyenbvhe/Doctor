import UIKit

class ArticleListViewController: UIViewController {

    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var tableView: UITableView!
    let viewModel = ArticleViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "HeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderTableViewCell")
        tableView.register(UINib(nibName: "DetailTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailTableViewCell")
        setupViewModel()
        viewModel.fetchNewsItems()  // Gọi hàm fetch dữ liệu từ ViewModel
        backButton.layer.cornerRadius = backButton.frame.size.width/2
        backButton.layer.borderColor = UIColor.systemGray3.cgColor
        backButton.layer.borderWidth = 1
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

    @IBAction func popDidtapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UITableViewDataSource
extension ArticleListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.listArticles.count  // Trả về số lượng bài viết trong danh sách
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let article = viewModel.listArticles[indexPath.row]

        if indexPath.row == 0 {
            // Sử dụng cell cho header nếu đây là dòng đầu tiên
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderTableViewCell", for: indexPath) as! HeaderTableViewCell
            cell.configure(with: article)
            return cell
        } else {
            // Sử dụng cell cho các dòng chi tiết
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailTableViewCell", for: indexPath) as! DetailTableViewCell
            cell.articleConfigure(with: article)
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 300
        }
        else {
            return 100
        }
    }
}

// MARK: - UITableViewDelegate
extension ArticleListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Xử lý sự kiện khi người dùng chọn một dòng trong bảng
        let article = viewModel.listArticles[indexPath.row]
        print("Selected article: \(article.title ?? "No title")")
        // Bạn có thể thực hiện các hành động khác khi người dùng chọn bài viết, ví dụ như mở một màn hình chi tiết bài viết
    }
}


