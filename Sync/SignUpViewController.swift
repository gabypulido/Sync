//
//  SignUpViewController.swift
//  Sync
//
//  Created by Maria Maynard on 10/21/20.
//  Copyright © 2020 Gabriela Pulido. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirm: UITextField!
    @IBOutlet weak var signUp: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        email.borderStyle = UITextField.BorderStyle.roundedRect
        username.borderStyle = UITextField.BorderStyle.roundedRect
        password.borderStyle = UITextField.BorderStyle.roundedRect
        confirm.borderStyle = UITextField.BorderStyle.roundedRect
        signUp.layer.cornerRadius = 10
        signUp.clipsToBounds = true
    }

    // when someone tries to sign up lets get their info and see if it works
    @IBAction func buttonPressed(_ sender: Any) {
        guard let emailText = email.text,
              let passwordText = password.text,
              let confirmText = confirm.text,
              let usernameText = username.text,
              emailText.count > 0,
              passwordText.count > 0,
              confirmText.count > 0,
              usernameText.count > 0,
              passwordText == confirmText
        else {
            let alert = UIAlertController(
              title: "Sign up failed",
              message: "Please check the fields and try again."
            ,
              preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:"OK",style:.default))
            self.present(alert, animated: true, completion: nil)
            return
        }
        Auth.auth().createUser(withEmail: emailText, password: passwordText) { user, error in
            if error == nil {
                Auth.auth().signIn(withEmail: emailText,
                                   password: passwordText)
                self.performSegue(withIdentifier: "signupSegueIdentifier", sender: nil)
            }
        }
    }
}
