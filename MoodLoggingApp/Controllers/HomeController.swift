//
//  HomeController.swift
//  MoodLoggingApp
//
//  Created by Pushparaj Samant on 25/4/22.
//

import UIKit
import Firebase
class HomeController: UIViewController {
    let db = Firestore.firestore()
    
    @IBOutlet weak var dailyDataView: UIStackView!
    @IBOutlet weak var todayMoodImageView: UIImageView!
    @IBOutlet weak var dailyDataMessage: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        checkUserHasDataForToday()
    }
    func checkUserHasDataForToday() {
        let userId = Auth.auth().currentUser?.uid
        let moodTrackerRef = db.collection("MoodTracker")
        var userHasDataForToday = false;
        moodTrackerRef
            .whereField("user", isEqualTo: userId)
            .whereField("date", isEqualTo: Date().timeIntervalSince1970)
        moodTrackerRef.getDocuments(source: .cache) { (querySnapshot, error) in
            print("Got data")
            if let snapshotDocuments = querySnapshot?.documents {
                for doc in snapshotDocuments {
                    let data = doc.data()
                    if data["mood"] != nil {
                        self.dailyDataView.isHidden = true
                        self.todayMoodImageView.isHidden = false
                        self.dailyDataMessage.text = "Today's Mood"
                    } else {
                        self.dailyDataView.isHidden = false
                        self.todayMoodImageView.isHidden = true
                        self.dailyDataMessage.text = "Rate your mood today"
                    }
                }
            }
        }
    }
    @IBAction func logoutAction(_ sender: UIBarButtonItem) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    @IBAction func moodPressedAction(_ sender: UIButton) {
        print(sender.currentTitle)
        if let moodToday = sender.currentTitle, let currentUser = Auth.auth().currentUser?.uid {
            db.collection("MoodTracker").addDocument(data: [
                "date": Date().timeIntervalSince1970,
                "mood": moodToday,
                "user": currentUser
            ]) { error in
                if error != nil {
                    print(error)
                }
            }
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
