//
//  ResetPasswordLoggedInViewController.swift
//  Sync
//
//  Created by Maria Maynard on 11/3/20.
//  Copyright © 2020 Gabriela Pulido. All rights reserved.
//

import UIKit
import FirebaseAuth

class ResetPasswordLoggedInViewController: UIViewController {

 
    @IBOutlet weak var reset: UIButton!
    @IBOutlet weak var newPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        newPassword.borderStyle = UITextField.BorderStyle.roundedRect
        reset.layer.cornerRadius = 10
        reset.clipsToBounds = true
    }
    
    @IBAction func resetPassword(_ sender: Any) {
        guard let passwordText = newPassword.text,
              passwordText.count > 0
        else {
            let alert = UIAlertController(
              title: "Reset failed",
              message: "Please type a new password."
            ,
              preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:"OK",style:.default))
            self.present(alert, animated: true, completion: nil)
            return
        }
        Auth.auth().currentUser?.updatePassword(to: newPassword.text!) { (error) in
            if let error = error {
                let alert = UIAlertController(
                  title: "Reset failed",
                  message: error.localizedDescription,
                  preferredStyle: .alert)
                alert.addAction(UIAlertAction(title:"OK",style:.default))
                self.present(alert, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(
                  title: "Password Reset",
                  message: "Your password has been changed."
                ,
                  preferredStyle: .alert)
                alert.addAction(UIAlertAction(title:"OK",style:.default))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}
