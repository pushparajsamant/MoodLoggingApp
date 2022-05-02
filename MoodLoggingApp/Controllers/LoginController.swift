//
//  ViewController.swift
//  MoodLoggingApp
//
//  Created by Pushparaj Samant on 22/4/22.
//

import UIKit
import FirebaseAuth
class LoginController: UIViewController {

    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    var userNameText: String?
    
    @IBAction func loginAction(_ sender: UIButton) {
        if let email = username.text, let passwordValue = password.text {
            Auth.auth().signIn(withEmail: email, password: passwordValue) { [weak self] authResult, error in
                if error != nil {
                    print(error!)
                } else {
                    self?.performSegue(withIdentifier: "loginToHome", sender: self)
                }

            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        username.attributedPlaceholder = NSAttributedString(string: "Enter username", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
        password.attributedPlaceholder = NSAttributedString(string: "Enter password", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
        username.text = userNameText ?? ""
    }


}

