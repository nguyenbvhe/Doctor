//
//  UserInformationViewController.swift
//  Doctor
//
//  Created by Minh Nguỵn on 29/8/24.
//

import UIKit

class UserInformationViewController: UIViewController, UITableViewDelegate {
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var tableView: UITableView!
    private var userViewModel = UserViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupBindings()
        userViewModel.fetchUserItems()  // Gọi API để lấy dữ liệu người dùng
        setupButton()
        
        // Thêm observers cho bàn phím
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        // Xoá observers khi view bị hủy
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // Kết nối ViewModel với TableView
    private func setupBindings() {
        userViewModel.onDataFetched = { [weak self] in
            self?.tableView.reloadData()
        }
        
        userViewModel.onError = { [weak self] errorMessage in
            print("Error: \(errorMessage)")
        }
    }
    
    func setupButton() {
        backButton.layer.cornerRadius = backButton.frame.size.width / 2
        backButton.layer.borderWidth = 1
        backButton.layer.borderColor = UIColor.systemGray3.cgColor
    }
    
    @IBAction func popDidTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "UserInformationTableViewCell", bundle: nil), forCellReuseIdentifier: "UserInformationTableViewCell")
        tableView.register(UINib(nibName: "GenderTableViewCell", bundle: nil), forCellReuseIdentifier: "GenderTableViewCell")
        tableView.register(UINib(nibName: "DoneButtonTableViewCell", bundle: nil), forCellReuseIdentifier: "DoneButtonTableViewCell")
        tableView.separatorStyle = .none
    }
    
    // Xử lý khi bàn phím hiển thị
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height
            let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
            tableView.contentInset = contentInsets
            tableView.scrollIndicatorInsets = contentInsets
        }
    }
    
    // Xử lý khi bàn phím ẩn
    @objc func keyboardWillHide(notification: NSNotification) {
        let contentInsets = UIEdgeInsets.zero
        tableView.contentInset = contentInsets
        tableView.scrollIndicatorInsets = contentInsets
    }
    
    // Ẩn bàn phím khi chạm ra ngoài trường văn bản
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

extension UserInformationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1  // Mỗi section chỉ có 1 dòng
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section + 1 {
        case 1, 2, 5, 6, 10:
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserInformationTableViewCell", for: indexPath) as! UserInformationTableViewCell
            configureTextCell(cell: cell, at: indexPath)
            return cell
            
        case 3, 7, 8, 9, 11:
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserInformationTableViewCell", for: indexPath) as! UserInformationTableViewCell
            configureAdditionalTextCell(cell: cell, at: indexPath)
            return cell
            
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "GenderTableViewCell", for: indexPath) as! GenderTableViewCell
            configureGenderCell(cell: cell, at: indexPath)
            return cell
            
        case 12:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DoneButtonTableViewCell", for: indexPath) as! DoneButtonTableViewCell
            cell.delegate = self
            return cell
            
        default:
            return UITableViewCell()  // Trả về một cell trống nếu không có case nào khớp
        }
    }
    
    func configureTextCell(cell: UserInformationTableViewCell, at indexPath: IndexPath) {
        let user = userViewModel.users.first
        
        switch indexPath.section + 1 {
        case 1:
            cell.titleLable.text = "Tên*"
            cell.enterTextField.text = user?.name
            cell.enterTextField.placeholder = "Nhập tên của bạn"
            
        case 2:
            cell.titleLable.text = "Họ*"
            cell.enterTextField.text = user?.lastName
            cell.enterTextField.placeholder = "Nhập họ của bạn"
            
        case 5:
            cell.titleLable.text = "Số điện thoại"
            cell.enterTextField.text = user?.phone
            cell.enterTextField.placeholder = "Nhập số điện thoại của bạn"
            
        case 6:
            cell.titleLable.text = "Email"
            cell.enterTextField.text = user?.contactEmail
            cell.enterTextField.placeholder = "Địa chỉ Email của bạn"
            
        case 10:
            cell.titleLable.text = "Địa chỉ nơi ở"
            cell.enterTextField.text = user?.address
            cell.enterTextField.placeholder = "Nơi thường trú của bạn"
            
        default:
            break
        }
        
        cell.enterTextField.tag = indexPath.section
        cell.seeMoreButton.isHidden = true
    }
    
    func configureAdditionalTextCell(cell: UserInformationTableViewCell, at indexPath: IndexPath) {
        let user = userViewModel.users.first
        
        switch indexPath.section + 1 {
        case 3:
            cell.titleLable.text = "Ngày sinh *"
            cell.enterTextField.text = user?.birthDate
            cell.enterTextField.placeholder = "DD/MM/YY"
            cell.seeMoreButton.isHidden = true
            
        case 7:
            cell.titleLable.text = "Tỉnh / Thành phố"
            cell.enterTextField.text = user?.provinceCode
            cell.enterTextField.placeholder = "Chưa cập nhật"
            cell.seeMoreButton.isHidden = true
            
        case 8:
            cell.titleLable.text = "Quận / Huyện"
            cell.enterTextField.text = user?.districtCode
            cell.enterTextField.placeholder = "Chưa cập nhật"
            cell.seeMoreButton.isHidden = true
            
        case 9:
            cell.titleLable.text = "Phường / Xã"
            cell.enterTextField.text = user?.wardCode
            cell.enterTextField.placeholder = "Chưa cập nhật"
            cell.seeMoreButton.isHidden = true
            
        case 11:
            cell.titleLable.text = "Nhóm máu"
            cell.enterTextField.text = user?.bloodName
            cell.enterTextField.placeholder = "A+/B+/AB/O"
            cell.seeMoreButton.isHidden = true
            
        default:
            break
        }
        
        cell.enterTextField.tag = indexPath.section
        cell.seeMoreButton.isHidden = false
    }
    
    func configureGenderCell(cell: GenderTableViewCell, at indexPath: IndexPath) {
        cell.chooseGenderSegmented.selectedSegmentIndex = userViewModel.users.first?.sex == 1 ? 0 : 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 12  // Tổng số sections
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section + 1 {
        case 12:
            return 70  // Đặt chiều cao riêng cho cell chứa button
        default:
            return 80  // Chiều cao mặc định cho các cell khác
        }
    }

    
}

extension UserInformationViewController: DoneButtonTableViewCellDelegate {
    func popDidTapped() {
        navigationController?.popViewController(animated: true)
    }
}
