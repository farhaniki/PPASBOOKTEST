import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var noicTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var confirmPasswordTextField: UITextField!
    @IBOutlet var fullnameTextField: UITextField!
    @IBOutlet var contactNumberTextField: UITextField!
    @IBOutlet var registerButton: UIButton!
    @IBOutlet var alertLabel: UILabel!
    
    var alertMessage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.clipToC()
        noicTextField.clipToC()
        passwordTextField.clipToC()
        confirmPasswordTextField.clipToC()
        fullnameTextField.clipToC()
        contactNumberTextField.clipToC()
        
        registerButton.layer.cornerRadius = 10
        registerButton.layer.borderColor = UIColor.systemTeal.cgColor
        registerButton.layer.borderWidth = 1.0
        alertLabel.isHidden = true
    }

    @IBAction func registerTapped(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty,
              let noic = noicTextField.text, !noic.isEmpty,
              let password = passwordTextField.text, !password.isEmpty,
              let confirmPassword = confirmPasswordTextField.text, !confirmPassword.isEmpty,
              let fullname = fullnameTextField.text, !fullname.isEmpty,
              let contactNumber = contactNumberTextField.text, !contactNumber.isEmpty else {
            showAlert(message: "Sila isi semua ruangan.")
            return
        }
        
        guard isValidEmail(email) else {
            showAlert(message: "Email mesti mengandungi @gmail.com.")
            return
        }
        
        guard isNumeric(noic) else {
            showAlert(message: "Nombor IC mesti hanya mengandungi nombor.")
            return
        }
        
        guard isNumeric(contactNumber) else {
            showAlert(message: "Nombor telefon mesti hanya mengandungi nombor.")
            return
        }
        
        guard isValidPassword(password) else {
            showAlert(message: "Kata laluan mesti mempunyai sekurang-kurangnya 8 aksara dan mengandungi sekurang-kurangnya satu nombor.")
            return
        }

        guard password == confirmPassword else {
            showAlert(message: "Kata laluan tidak sepadan.")
            return
        }

        // Jika semua validasi lulus
        alertMessage = "Pendaftaran Berjaya!"
        showAlert(message: alertMessage!, isError: false)
        
        // Perform segue hanya setelah semua validasi lulus
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.performSegue(withIdentifier: "goToLogin", sender: self)
        }
    }
    
    func showAlert(message: String, isError: Bool = true) {
        alertLabel.text = message
        alertLabel.textColor = isError ? .red : .green
        alertLabel.isHidden = false
    }

    func isValidEmail(_ email: String) -> Bool {
        return email.contains("@gmail.com")
    }
    
    func isNumeric(_ string: String) -> Bool {
        return !string.isEmpty && string.allSatisfy { $0.isNumber }
    }
    
    func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[0-9]).{8,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordTest.evaluate(with: password)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToLogin" {
            let destinationVC = segue.destination as? LoginViewController
            destinationVC?.alertMessage = alertMessage
        }
    }
}

extension UITextField {
    func clipToC() {
        self.layoutIfNeeded()
        self.layer.borderColor=UIColor.systemTeal.cgColor
        self.layer.borderWidth = 5.0
        self.layer.cornerRadius =
        self.frame.height / 10
        self.clipsToBounds = true
    }
}
