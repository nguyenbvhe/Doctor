import UIKit
import IQKeyboardManagerSwift

class SMSCodeViewController: UIViewController {

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

    @IBOutlet weak var continueButtonBottomContraint: NSLayoutConstraint!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureTextFields()
        addDoneButtonOnKeyboard() // Thêm nút "Done" trên bàn phím
        registerKeyboardNotifications()
    }

    func setupUI() {
        // Customize UI elements
        backButton.layer.cornerRadius = backButton.frame.size.width / 2
        continueButton.layer.cornerRadius = 24
        continueButton.isEnabled = false // Disable continue button initially
        validLabel.isHidden = true // Hidden initially
    }

    @IBAction func backActionTapped(_ sender: Any) {
        // Pop view controller to go back
        self.navigationController?.popViewController(animated: true)
    }

    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }

        // Ensure each text field only contains one character
        if text.count > 1 {
            textField.text = String(text.last!)
        }

        // Move to next text field if the current one is filled
        if text.count == 1, let nextTextField = getNextTextField(from: textField) {
            nextTextField.becomeFirstResponder()
        }

        // If all text fields are filled, validate the input
        validateCode()
    }

    func validateCode() {
        let textFields = [codeOneTextField, codeSecondTextField, codeThreeTextField, codeFourTextField, codeFiveTextField, codeSixTextField]

        // Get the combined input from all text fields
        let code = textFields.compactMap { $0?.text }.joined()

        // Check if all text fields are filled
        if code.count == 6 {
            // Check if the code is correct (in this example, the correct code is "111111")
            if code == "111111" {
                validLabel.isHidden = true // Hide the validLabel if code is correct
                continueButton.isEnabled = true
                continueButton.backgroundColor = BaseColor.primaryColor
            } else {
                validLabel.isHidden = false // Show the validLabel if code is incorrect
                continueButton.isEnabled = false
                continueButton.backgroundColor = UIColor.gray
            }
        } else {
            // If the user hasn't completed entering all the numbers, hide the validLabel
            validLabel.isHidden = true
        }
    }
    
    @IBAction func doneActionTapped(_ sender: Any) {
        let vc = HomeViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

    // MARK: - Add Done Button on Keyboard
    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar()
        doneToolbar.barStyle = .default

        // Tạo một flexible space để đẩy nút Done sang bên phải
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonAction))

        doneToolbar.items = [flexSpace, doneButton]
        doneToolbar.sizeToFit()

        // Thêm toolbar vào tất cả các text fields
        let textFields = [codeOneTextField, codeSecondTextField, codeThreeTextField, codeFourTextField, codeFiveTextField, codeSixTextField]
        textFields.forEach { $0?.inputAccessoryView = doneToolbar }
    }

    @objc func doneButtonAction() {
        // Hide the keyboard
        view.endEditing(true)
    }
}

extension SMSCodeViewController: UITextFieldDelegate {
    func configureTextFields() {
        let textFields = [codeOneTextField, codeSecondTextField, codeThreeTextField, codeFourTextField, codeFiveTextField, codeSixTextField]

        for textField in textFields {
            textField?.keyboardType = .numberPad
            textField?.delegate = self
            textField?.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            textField?.layer.borderColor = UIColor.gray.cgColor
            textField?.layer.borderWidth = 1.0
        }

    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Highlight the border with the desired color when editing starts
        textField.layer.borderColor = BaseColor.primaryColor.cgColor
        textField.layer.borderWidth = 2.0
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        // Reset the border to gray when editing ends
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 1.0
    }

    func getNextTextField(from textField: UITextField) -> UITextField? {
        let textFields = [codeOneTextField, codeSecondTextField, codeThreeTextField, codeFourTextField, codeFiveTextField, codeSixTextField]

        if let currentIndex = textFields.firstIndex(of: textField) {
            // Return the next text field if available
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
            // Return the previous text field if available
            let previousIndex = currentIndex - 1
            if previousIndex >= 0 {
                return textFields[previousIndex]
            }
        }
        return nil
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Allow deleting (backspacing) characters
        if string.isEmpty {
            if textField.text?.isEmpty == true, let previousTextField = getPreviousTextField(from: textField) {
                previousTextField.becomeFirstResponder()
                previousTextField.text = "" // Clear the previous field
            }
            return true
        }

        // Ensure only one character can be entered in each text field
        if let text = textField.text, text.count >= 1 {
            return false
        }
        return true
    }
}
// MARK: - UIKeyBoard Handling
extension SMSCodeViewController {
    
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
        
        // Điều chỉnh khoảng cách từ nút `continueButton` đến đáy view bằng chiều cao của bàn phím
        continueButtonBottomContraint.constant = keyboardHeight + 20 // Thêm 20 để tạo khoảng cách giữa nút và bàn phím
        
        // Animate layout change
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        // Reset lại khoảng cách ban đầu của constraint
        continueButtonBottomContraint.constant = 30 // Khoảng cách ban đầu (hoặc giá trị bạn muốn)
        
        // Animate layout change
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}
