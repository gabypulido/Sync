//
//  ChangePasswordViewController.swift
//  Sync
//
//  Created by Audrey Chung on 10/22/20.
//  Copyright © 2020 Gabriela Pulido. All rights reserved.
//

import UIKit
import FirebaseAuth

class ChangePasswordViewController: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var reset: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        email.borderStyle = UITextField.BorderStyle.roundedRect
        reset.layer.cornerRadius = 10
        reset.clipsToBounds = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func resetPassword(_ sender: Any) {
        guard let emailText = email.text,
              emailText.count > 0
        else {
            let alert = UIAlertController(
              title: "Reset failed",
              message: "Please check the fields and try again."
            ,
              preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:"OK",style:.default))
            self.present(alert, animated: true, completion: nil)
            return
        }
        Auth.auth().sendPasswordReset(withEmail: emailText) { error in
            if let error = error {
                let alert = UIAlertController(
                  title: "Reset failed",
                  message: error.localizedDescription,
                  preferredStyle: .alert)
                alert.addAction(UIAlertAction(title:"OK",style:.default))
                self.present(alert, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(
                  title: "Email Sent",
                  message: "Check your inbox to reset your password."
                ,
                  preferredStyle: .alert)
                alert.addAction(UIAlertAction(title:"OK",style:.default))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
}
