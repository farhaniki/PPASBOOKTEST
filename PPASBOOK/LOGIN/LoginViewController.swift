import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var noicTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var alertLabel: UILabel!
    @IBOutlet var newUser: UIButton!
    
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
            showAlert(message: "Sila isi semua maklumat.")
            return
        }
        
        guard isNumeric(noic) else {
            showAlert(message: "Nombor IC mesti mengandungi nombor sahaja.")
            return
        }

        // Example login check
        if noic == "040401100229" && password == "ACHONG" {
            showAlert(message: "Login Berjaya!", isError: false)
            // Menunda pemanggilan performSegue selama 2 detik
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.navigateToNextScreen()
            }
        } else {
            showAlert(message: "NoIC atau Kata Laluan tidak sah.")
        }
    }
    
    @IBAction func newUserTapped(_ sender: UIButton) {
        if let url = URL(string: "http://opac.ppas.gov.my:8080/wicket/bookmarkable/com.vtls.chamo.webapp.component.patron.PatronRegistrationPage?theme=ppas_chamo") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
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
