//
//  LandingController.swift
//  MoodLoggingApp
//
//  Created by Pushparaj Samant on 25/4/22.
//

import UIKit
import FirebaseAuth
class LandingController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        if let _ = Auth.auth().currentUser {
            performSegue(withIdentifier: "landingToHome", sender: self)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
