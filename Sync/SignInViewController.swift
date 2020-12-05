//
//  SignInViewController.swift
//  Sync
//
//  Created by Ji-Young Seo on 10/21/20.
//  Copyright © 2020 Gabriela Pulido. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class SignInViewController: UIViewController, GIDSignInDelegate {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var googleSignInButton: UIButton!
    @IBOutlet weak var resetPasswordButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
//            let alert = UIAlertController(
//                title: "Sign in failed",
//                  message: error.localizedDescription,
//                preferredStyle: .alert)
//              alert.addAction(UIAlertAction(title:"OK",style:.default))
//              self.present(alert, animated: true, completion: nil)
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
                    self.performSegue(withIdentifier: "signInSegueIdentifier", sender: nil)
                }
            })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()!.options.clientID
        GIDSignIn.sharedInstance().delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        emailTextField.borderStyle = UITextField.BorderStyle.roundedRect
        passwordTextField.borderStyle = UITextField.BorderStyle.roundedRect
        signInButton.layer.cornerRadius = 10
        signInButton.clipsToBounds = true
        googleSignInButton.layer.cornerRadius = 10
        googleSignInButton.clipsToBounds = true
        resetPasswordButton.layer.cornerRadius = 10
        resetPasswordButton.clipsToBounds = true
        signUpButton.layer.cornerRadius = 10
        signUpButton.clipsToBounds = true
    }
    
    @IBAction func signInButtonPressed(_ sender: Any) {
        guard let emailText = emailTextField.text,
              let passwordText = passwordTextField.text,
              emailText.count > 0,
              passwordText.count > 0
        else {
            let alert = UIAlertController(
              title: "Sign in failed",
              message: "Please check the fields and try again."
            ,
              preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:"OK",style:.default))
            self.present(alert, animated: true, completion: nil)
            return
        }
        Auth.auth().signIn(withEmail: emailText, password: passwordText) { user, error in
            if let error = error, user == nil {
                let alert = UIAlertController(
                  title: "Sign in failed",
                  message: error.localizedDescription,
                  preferredStyle: .alert)
                alert.addAction(UIAlertAction(title:"OK",style:.default))
                self.present(alert, animated: true, completion: nil)
            } else {
                self.performSegue(withIdentifier: "signInSegueIdentifier", sender: nil)
            }
        }
    }
    
    @IBAction func resetPasswordButtonPressed(_ sender: Any) {
    }
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "signInToUpSegueIdentifier", sender: nil)
    }
    
    @IBAction func googleSignIn(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    // code to enable tapping on the background to remove software keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
