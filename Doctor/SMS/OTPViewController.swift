import UIKit
import IQKeyboardManagerSwift
import AEOTPTextField

class OTPViewController: UIViewController {
    
    @IBOutlet private weak var validLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var displayPhoneLabel: UILabel!
    @IBOutlet private weak var codeOneTextField: UITextField!
    @IBOutlet private weak var codeSecondTextField: UITextField!
    @IBOutlet private weak var codeThreeTextField: UITextField!
    @IBOutlet private weak var codeFourTextField: UITextField!
    @IBOutlet private weak var codeFiveTextField: UITextField!
    @IBOutlet private weak var codeSixTextField: UITextField!
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var continueButton: UIButton!
    @IBOutlet private weak var countdownOTPLable: UILabel!
    @IBOutlet private weak var continueButtonBottomContraint: NSLayoutConstraint!
    
    var phoneNumber: String?  // Property to hold the passed phone number
    var countdownTimer: Timer?
    var remainingSeconds: Int = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureTextFields()
        addDoneButtonOnKeyboard()
        registerKeyboardNotifications()
        navigationController?.isNavigationBarHidden = true
        
        // Display the phone number passed from LoginViewController
        if let phoneNumber = phoneNumber {
            displayPhoneLabel.text = "Vui lòng nhập mã gồm 6 chữ số đã được gửi đến bạn vào số điện thoại \(phoneNumber)"
        }
        countdownOTPLable.isUserInteractionEnabled = false
        // Start the OTP countdown as soon as the view loads
        startOTPTimer()
    }
   
    
    func setupUI() {
        backButton.layer.cornerRadius = backButton.frame.size.width / 2
        continueButton.layer.cornerRadius = 24
        codeOneTextField.layer.cornerRadius = 8
        codeSecondTextField.layer.cornerRadius = 8
        codeThreeTextField.layer.cornerRadius = 8
        codeFourTextField.layer.cornerRadius = 8
        codeFiveTextField.layer.cornerRadius = 8
        codeSixTextField.layer.cornerRadius = 8
        continueButton.isEnabled = false
        validLabel.isHidden = true
        countdownOTPLable.text = "Gửi lại mã sau 60s"
    }
    
    @IBAction func backActionTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        // Ensure each text field only contains one character
        if text.count > 1 {
            textField.text = String(text.last!)
        }
        
        // Move to next text field if the current one is filled
        if text.count == 1 {
            switch textField {
            case codeOneTextField:
                codeSecondTextField.becomeFirstResponder()
            case codeSecondTextField:
                codeThreeTextField.becomeFirstResponder()
            case codeThreeTextField:
                codeFourTextField.becomeFirstResponder()
            case codeFourTextField:
                codeFiveTextField.becomeFirstResponder()
            case codeFiveTextField:
                codeSixTextField.becomeFirstResponder()
            case codeSixTextField:
                codeSixTextField.resignFirstResponder()
            default:
                break
            }
        }
        
        // Move to previous text field if the current one is empty
        if text.count == 0 {
            switch textField {
            case codeOneTextField:
                codeOneTextField.becomeFirstResponder()
            case codeSecondTextField:
                codeOneTextField.becomeFirstResponder()
            case codeThreeTextField:
                codeSecondTextField.becomeFirstResponder()
            case codeFourTextField:
                codeThreeTextField.becomeFirstResponder()
            case codeFiveTextField:
                codeFourTextField.becomeFirstResponder()
            case codeSixTextField:
                codeFiveTextField.becomeFirstResponder()
            default:
                break
            }
        }
        
        // If all text fields are filled, validate the input
        validateCode()
    }
    
    func startOTPTimer() {
        countdownTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCountdown), userInfo: nil, repeats: true)
    }
    
    @objc func updateCountdown() {
        if remainingSeconds > 0 {
            remainingSeconds -= 1
            countdownOTPLable.text = "Gửi lại mã sau \(remainingSeconds)s"
            countdownOTPLable.isUserInteractionEnabled = false
            countdownOTPLable.textColor = UIColor.gray
            countdownOTPLable.layer.borderColor = UIColor.gray.cgColor
            countdownOTPLable.layer.borderWidth = 1
            countdownOTPLable.layer.cornerRadius = 15
        } else {
            countdownTimer?.invalidate()
            countdownTimer = nil
            countdownOTPLable.text = "Gửi lại mã"
            countdownOTPLable.isUserInteractionEnabled = true
            countdownOTPLable.textColor = BaseColor.primaryColor
            countdownOTPLable.layer.borderColor = BaseColor.primaryColor.cgColor
            countdownOTPLable.layer.borderWidth = 1
            countdownOTPLable.layer.cornerRadius = 15
            countdownOTPLable.layer.masksToBounds = true
            addTapGestureToCountdownLabel() // Thêm hành động tap khi đếm ngược kết thúc
        }
    }
    func addTapGestureToCountdownLabel() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleResendTap))
        countdownOTPLable.addGestureRecognizer(tapGesture)
        countdownOTPLable.isUserInteractionEnabled = true
    }

    @objc func handleResendTap() {
        // Restart the countdown timer
        remainingSeconds = 60
        countdownOTPLable.isUserInteractionEnabled = false
        countdownOTPLable.textColor = UIColor.black
        countdownOTPLable.layer.borderColor = UIColor.clear.cgColor
        countdownOTPLable.layer.borderWidth = 0
        startOTPTimer() // Bắt đầu lại đếm ngược
    }

    
    func validateCode() {
        let textFields = [codeOneTextField, codeSecondTextField, codeThreeTextField, codeFourTextField, codeFiveTextField, codeSixTextField]
        let code = textFields.compactMap { $0?.text }.joined()
        
        if code.count == 6 {
            if code == "111111" {
                validLabel.isHidden = true
                continueButton.isEnabled = true
                continueButton.backgroundColor = BaseColor.primaryColor
            } else {
                validLabel.isHidden = false
                continueButton.isEnabled = false
                continueButton.backgroundColor = UIColor.gray
            }
        } else {
            validLabel.isHidden = true
        }
    }
    
    @IBAction func doneActionTapped(_ sender: Any) {
        let vc = HomeViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar()
        doneToolbar.barStyle = .default
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonAction))
        doneToolbar.items = [flexSpace, doneButton]
        doneToolbar.sizeToFit()
        let textFields = [codeOneTextField, codeSecondTextField, codeThreeTextField, codeFourTextField, codeFiveTextField, codeSixTextField]
        textFields.forEach { $0?.inputAccessoryView = doneToolbar }
    }
    
    @objc func doneButtonAction() {
        view.endEditing(true)
    }
}
// MARK: - UITextFieldDelegate
extension OTPViewController: UITextFieldDelegate {
    func configureTextFields() {
        let textFields = [codeOneTextField, codeSecondTextField, codeThreeTextField, codeFourTextField, codeFiveTextField, codeSixTextField]
        for textField in textFields {
            textField?.keyboardType = .numberPad
            textField?.delegate = self
            textField?.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            textField?.layer.borderColor = UIColor.white.cgColor
            textField?.layer.borderWidth = 1.0
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = BaseColor.primaryColor.cgColor
        textField.layer.borderWidth = 2.0
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 1.0
    }
    
    func getNextTextField(from textField: UITextField) -> UITextField? {
        let textFields = [codeOneTextField, codeSecondTextField, codeThreeTextField, codeFourTextField, codeFiveTextField, codeSixTextField]
        if let currentIndex = textFields.firstIndex(of: textField) {
            let nextIndex = currentIndex + 1
            if nextIndex < textFields.count {
                return textFields[nextIndex]
            }
        }
        return nil
    }
    
    func getPreviousTextField(from textField: UITextField) -> UITextField? {
        let textFields = [codeOneTextField, codeSecondTextField, codeThreeTextField, codeFourTextField, codeFiveTextField, codeSixTextField]
        if let currentIndex = textFields.firstIndex(of: textField) {
            let previousIndex = currentIndex - 1
            if previousIndex >= 0 {
                return textFields[previousIndex]
            }
        }
        return nil
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Xóa ký tự
        if string.isEmpty {
            textField.text = "" // Xóa ký tự trong ô hiện tại
            if let previousTextField = getPreviousTextField(from: textField) {
                previousTextField.becomeFirstResponder() // Di chuyển con trỏ đến ô trước đó
            }
            return false // Ngăn không cho tự động xóa ký tự hiện tại để có thể xóa từ phải sang trái
        }
        
        // Đảm bảo chỉ một ký tự có thể được nhập vào mỗi ô
        if let text = textField.text, text.count >= 1 {
            textField.text = string // Thay thế ký tự cũ bằng ký tự mới
            // Di chuyển con trỏ tới ô tiếp theo nếu có
            if let nextTextField = getNextTextField(from: textField) {
                nextTextField.becomeFirstResponder()
            }
            return false
        }
        
        return true // Cho phép nhập ký tự mới
    }

}
// MARK: - UIKeyBoard Handling
extension OTPViewController {
    
    func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardHeight = keyboardFrame.cgRectValue.height
        continueButtonBottomContraint.constant = keyboardHeight + 20
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        continueButtonBottomContraint.constant = 30
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}
