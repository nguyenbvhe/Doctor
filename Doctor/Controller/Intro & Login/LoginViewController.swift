import UIKit
import IQKeyboardManagerSwift

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var languageButton: UIButton!
    @IBOutlet private weak var phoneNumberTextField: UITextField!
    @IBOutlet private weak var continueButton: UIButton!
    @IBOutlet private weak var hotlineView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        phoneNumberTextField.delegate = self
        phoneNumberTextField.keyboardType = .numberPad
        phoneNumberTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        setupUI()
    }
    
    func setupUI() {
        backButton.layer.cornerRadius = backButton.frame.size.width / 2
        languageButton.layer.cornerRadius = 15
        phoneNumberTextField.layer.cornerRadius = 28
        phoneNumberTextField.layer.borderWidth = 1
        phoneNumberTextField.layer.borderColor = UIColor.gray.cgColor
        continueButton.layer.cornerRadius = 24
        continueButton.backgroundColor = UIColor.gray
        
        
    }
    
    @IBAction func backActionTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func doneActionTapped(_ sender: Any) {
        guard continueButton.isEnabled, let text = phoneNumberTextField.text, !text.isEmpty else {
            print("Invalid phone number or continueButton is not enabled")
            return
        }
        
        let number = "+84 \(text)"
        print("Starting auth for: \(number)")
        
        // Push to SMSCodeVC
        let smsCodeVC = SMSCodeViewController()
        self.navigationController?.pushViewController(smsCodeVC, animated: true)
    }
    
    
    @IBAction func hotlineSelectTapped(_ sender: Any) {
        let hotlineNumber = "19006036893"
              if let phoneURL = URL(string: "tel://\(hotlineNumber)"), UIApplication.shared.canOpenURL(phoneURL) {
                  UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
              } else {
                  print("This device cannot make phone calls.")
                  // Có thể hiển thị cảnh báo cho người dùng nếu thiết bị không hỗ trợ gọi điện thoại
              }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        let isValidPhoneNumber = (text.count == 9 || text.count == 10) && !text.isEmpty
        continueButton.isEnabled = isValidPhoneNumber
        continueButton.backgroundColor = isValidPhoneNumber ? BaseColor.primaryColor : UIColor.gray
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == phoneNumberTextField {
            phoneNumberTextField.layer.borderColor = BaseColor.primaryColor.cgColor // Highlight viền khi bắt đầu nhập liệu
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == phoneNumberTextField {
            phoneNumberTextField.layer.borderColor = UIColor.gray.cgColor // Trở lại màu viền ban đầu khi kết thúc nhập liệu
        }
    }
}
