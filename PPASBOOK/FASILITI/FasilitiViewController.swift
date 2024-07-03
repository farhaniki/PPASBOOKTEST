import UIKit

class FasilitiViewController: UIViewController {
    
    @IBOutlet var backButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Lakukan sebarang persediaan tambahan selepas muatkan paparan.
    }
    
    // Tindakan untuk butang kembali
    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
        // Tangani tindakan ketika butang kembali ditekan
        navigationController?.popViewController(animated: true)
    }
    
}
