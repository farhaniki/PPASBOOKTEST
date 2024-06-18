//
//  LaunchScreenViewController.swift
//  PPASBOOK
//
//  Created by STDC_16 on 18/06/2024.
//

import UIKit

class LaunchScreenViewController: UIViewController {

    @IBOutlet var Logo: UIImageView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        Logo.clipToA()
        
    }
    }
    

    extension UIImageView{
        func clipToA() {
            self.layoutIfNeeded()
            self.layer.borderColor=UIColor.systemGray.cgColor
            self.layer.borderWidth = 5.0
            self.layer.cornerRadius =
            self.frame.height / 6
            self.clipsToBounds = true
        }
    }
