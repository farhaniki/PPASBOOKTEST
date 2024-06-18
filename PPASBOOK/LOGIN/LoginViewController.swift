import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var noicTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var alertLabel: UILabel!
    
    var alertMessage: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        noicTextField.clipToCircle()
        passwordTextField.clipToCircle()
        
        loginButton.layer.cornerRadius = 10
        loginButton.layer.borderColor = UIColor.systemTeal.cgColor
        loginButton.layer.borderWidth = 1.0
        alertLabel.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let message = alertMessage {
            showAlert(message: message, isError: false)
            alertMessage = nil // Clear the message after showing it
        }
    }

    @IBAction func loginTapped(_ sender: UIButton) {
        guard let noic = noicTextField.text, !noic.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            showAlert(message: "Sila isi semua ruangan.")
            return
        }
        
        guard isNumeric(noic) else {
            showAlert(message: "Nombor IC mesti mengandungi nombor sahaja.")
            return
        }

        // Example login check
        if noic == "040401100229" && password == "SyapuL04" {
            showAlert(message: "Login Berjaya!", isError: false)
            // Menunda pemanggilan performSegue selama 2 detik
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.navigateToNextScreen()
            }
        } else {
            showAlert(message: "NoIC atau Kata Laluan tidak sah.")
        }
    }
    
    func showAlert(message: String, isError: Bool = true) {
        alertLabel.text = message
        alertLabel.textColor = isError ? .red : .green
        alertLabel.isHidden = false
    }

    func isNumeric(_ string: String) -> Bool {
        return !string.isEmpty && string.allSatisfy { $0.isNumber }
    }
    
    func navigateToNextScreen() {
        // Ganti "NextViewController" dengan identifier nama ViewController berikutnya di storyboard
        performSegue(withIdentifier: "goToMainPage", sender: self)
    }
}

extension UITextField {
    func clipToCircle() {
        self.layoutIfNeeded()
        self.layer.borderColor=UIColor.systemTeal.cgColor
        self.layer.borderWidth = 5.0
        self.layer.cornerRadius =
        self.frame.height / 10
        self.clipsToBounds = true
    }
}
