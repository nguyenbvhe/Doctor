import UIKit

class DoctorListViewController: UIViewController {
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var tableView: UITableView!
    
    var viewModel = DoctorViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupViewModel()
        viewModel.fetchDoctorItems()
        configureBackButton()
        tableView.separatorStyle = .none

    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "DoctorListTableViewCell", bundle: nil), forCellReuseIdentifier: "DoctorListTableViewCell")
    }
    
    private func setupViewModel() {
        viewModel.onDataFetched = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        viewModel.onError = { errorMessage in
            print("Error: \(errorMessage)")
            // You can display an alert or error message here.
        }
    }
    
    private func configureBackButton() {
        backButton.layer.cornerRadius = backButton.frame.size.width / 2
        backButton.layer.borderWidth = 1
        backButton.layer.borderColor = UIColor.systemGray3.cgColor
    }
    
    @IBAction func popDidTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension DoctorListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.listDoctor.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let doctor = viewModel.listDoctor[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DoctorListTableViewCell", for: indexPath) as? DoctorListTableViewCell else {
            return UITableViewCell()
        }
        cell.doctorConfigure(with: doctor)
        return cell
    }
}

extension DoctorListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let doctor = viewModel.listDoctor[indexPath.row]
        
        // Chiều rộng của cell (bằng với chiều rộng của table view)
        let width = tableView.frame.width - 40 // Trừ khoảng cách padding hai bên nếu cần
        
        // Phông chữ sử dụng cho các nhãn
        let fontName = UIFont.systemFont(ofSize: 18)  // Phông chữ cho tên bác sĩ
        let fontMajor = UIFont.systemFont(ofSize: 16) // Phông chữ cho chuyên ngành
        
        // Tính chiều cao của các nhãn
        let nameHeight = heightForLabel(width: width, font: fontName, text: doctor.fullName ?? "")
        let majorHeight = heightForLabel(width: width, font: fontMajor, text: "Chuyên ngành: \(doctor.majorsName ?? "")")
        
        // Chiều cao cố định của ảnh bác sĩ
        let imageHeight: CGFloat = 45
        
        // Khoảng padding giữa các phần tử
        let padding: CGFloat = 10
        
        // Tổng chiều cao của cell
        let totalHeight = nameHeight + majorHeight + imageHeight + (padding * 3) // Padding cho mỗi phần tử
        
        return totalHeight
    }
    
    // Hàm tính chiều cao của nhãn
    func heightForLabel(width: CGFloat, font: UIFont, text: String) -> CGFloat {
        let constraintSize = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = text.boundingRect(with: constraintSize, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        return ceil(boundingBox.height)
    }
}
