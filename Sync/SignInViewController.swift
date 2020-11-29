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
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let authentication = user.authentication {
                let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)

            Auth.auth().signIn(with: credential, completion: { (user, error) -> Void in
                    if error != nil {
                        print("Problem at signing in with google with error : \(error)")
                    } else if error == nil {
                        print("user successfully signed in through GOOGLE! uid:\(Auth.auth().currentUser!.uid)")
                        print("signed in")
                        self.performSegue(withIdentifier: "signInSegueIdentifier", sender: nil)
                    }
                })
            }
//        self.performSegue(withIdentifier: "signInSegueIdentifier", sender: nil)
    }
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var resetPasswordButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    private var authListener: AuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()!.options.clientID
        GIDSignIn.sharedInstance().delegate = self
//        GIDSignIn.sharedInstance().signIn()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        emailTextField.borderStyle = UITextField.BorderStyle.roundedRect
        passwordTextField.borderStyle = UITextField.BorderStyle.roundedRect
        signInButton.layer.cornerRadius = 10
        signInButton.clipsToBounds = true
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
    
}
