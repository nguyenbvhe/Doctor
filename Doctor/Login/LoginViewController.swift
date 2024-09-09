import UIKit
import IQKeyboardManagerSwift

class LoginViewController: UIViewController {
    
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var languageButton: UIButton!
    @IBOutlet private weak var phoneNumberTextField: UITextField!
    @IBOutlet private weak var continueButton: UIButton!
    @IBOutlet private weak var hotlineView: UIView!
    @IBOutlet private weak var phoneNumberView: UIView!
    @IBOutlet private weak var deleteNumberButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        phoneNumberTextField.delegate = self
        phoneNumberTextField.keyboardType = .numberPad
        phoneNumberTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        applyShadow(to: phoneNumberView)
        setupUI()
        setupTapGestureToDismissKeyboard()
        updateDeleteButtonVisibility()  // Initialize delete button visibility
    }
    
    func setupUI() {
        backButton.layer.cornerRadius = backButton.frame.size.width / 2
        languageButton.layer.cornerRadius = 15
        phoneNumberView.layer.cornerRadius = 28
        phoneNumberView.layer.borderWidth = 1
        phoneNumberView.layer.borderColor = UIColor.white.cgColor  // Set initial border color to white
        continueButton.layer.cornerRadius = 24
        continueButton.backgroundColor = UIColor(hex: "#0EAD69").withAlphaComponent(0.5) // Default background color (lightened)
        continueButton.setTitleColor(.white, for: .normal)
        hotlineView.layer.cornerRadius = 24
        deleteNumberButton.layer.cornerRadius = deleteNumberButton.frame.size.width / 2
        deleteNumberButton.isHidden = true  // Hide delete button initially
    }

    private func setupTapGestureToDismissKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
        phoneNumberView.layer.borderColor = UIColor.white.cgColor  // Reset border color when keyboard is dismissed
    }

   
    private func validatePhoneNumber(_ phoneNumber: String) -> Bool {
        if phoneNumber.count == 9 && phoneNumber.first != "0" {
            return true
        }
        if phoneNumber.count == 10 && phoneNumber.first == "0" {
            return true
        }
        return false
    }
    
   

    private func applyShadow(to view: UIView) {
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowOpacity = 0.3
        view.layer.shadowRadius = 4
        view.layer.masksToBounds = false
    }
    
    private func updateDeleteButtonVisibility() {
        if let text = phoneNumberTextField.text, !text.isEmpty {
            deleteNumberButton.isHidden = false
        } else {
            deleteNumberButton.isHidden = true
        }
    }
    
    @IBAction func deleteDidtapped(_ sender: Any) {
        phoneNumberTextField.text = ""
        textFieldDidChange(phoneNumberTextField)  // Update button states
        updateDeleteButtonVisibility()  // Update delete button visibility
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
        
        // Pass the phone number to SMSCodeViewController
        let smsCodeVC = OTPViewController()
        smsCodeVC.phoneNumber = number  // Set the phone number
        self.navigationController?.pushViewController(smsCodeVC, animated: true)
    }

    
    @IBAction func hotlineSelectTapped(_ sender: Any) {
        let hotlineNumber = "19006036893"
        if let phoneURL = URL(string: "tel://\(hotlineNumber)"), UIApplication.shared.canOpenURL(phoneURL) {
            UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
        } else {
            print("This device cannot make phone calls.")
            // Optionally show an alert to the user
        }
    }
}
// MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {

    @objc func textFieldDidChange(_ textField: UITextField) {
        updateDeleteButtonVisibility()  // Update delete button visibility
        guard let text = textField.text else { return }
        let isValidPhoneNumber = validatePhoneNumber(text)
        continueButton.isEnabled = isValidPhoneNumber
        continueButton.backgroundColor = isValidPhoneNumber ? BaseColor.primaryColor : UIColor(hex: "#0EAD69").withAlphaComponent(0.5)
    }

    // Chỉ cho phép nhập số
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet(charactersIn: "0123456789")
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }

     func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == phoneNumberTextField {
            phoneNumberView.layer.borderColor = BaseColor.primaryColor.cgColor // Highlight border when user starts editing
        }
    }
}

