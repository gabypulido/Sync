//
//  SignUpViewController.swift
//  Sync
//
//  Created by Maria Maynard on 10/21/20.
//  Copyright © 2020 Gabriela Pulido. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class SignUpViewController: UIViewController, GIDSignInDelegate{

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirm: UITextField!
    @IBOutlet weak var signUp: UIButton!
    @IBOutlet weak var googleSignInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()!.options.clientID
        GIDSignIn.sharedInstance().delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        email.borderStyle = UITextField.BorderStyle.roundedRect
        username.borderStyle = UITextField.BorderStyle.roundedRect
        password.borderStyle = UITextField.BorderStyle.roundedRect
        confirm.borderStyle = UITextField.BorderStyle.roundedRect
        signUp.layer.cornerRadius = 10
        signUp.clipsToBounds = true
        googleSignInButton.layer.cornerRadius = 10
        googleSignInButton.clipsToBounds = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           self.view.endEditing(true)
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
            if let error = error, user == nil {
                let alert = UIAlertController(
                  title: "Sign up failed",
                  message: error.localizedDescription,
                  preferredStyle: .alert)
                alert.addAction(UIAlertAction(title:"OK",style:.default))
                self.present(alert, animated: true, completion: nil)
            } else {
                Auth.auth().signIn(withEmail: emailText,
                                   password: passwordText)
                self.performSegue(withIdentifier: "signupSegueIdentifier", sender: nil)
            }
            
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            let alert = UIAlertController(
                title: "Sign in failed",
                  message: error.localizedDescription,
                preferredStyle: .alert)
              alert.addAction(UIAlertAction(title:"OK",style:.default))
              self.present(alert, animated: true, completion: nil)
            return
          }
          guard let authentication = user.authentication else { return }
          let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        Auth.auth().signIn(with: credential, completion: { (user, error) -> Void in
                if let error = error, user == nil {
//                    let alert = UIAlertController(
//                      title: "Sign in failed",
//                        message: error.localizedDescription,
//                      preferredStyle: .alert)
//                    alert.addAction(UIAlertAction(title:"OK",style:.default))
//                    self.present(alert, animated: true, completion: nil)
                } else if error == nil {
                    self.performSegue(withIdentifier: "signupSegueIdentifier", sender: nil)
                }
            })
    }
    
    @IBAction func googleSignIn(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
    }
}
