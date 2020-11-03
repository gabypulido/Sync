//
//  OptInViewController.swift
//  Sync
//
//  Created by Maria Maynard on 10/21/20.
//  Copyright © 2020 Gabriela Pulido. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class OptInViewController: UIViewController {

    @IBOutlet weak var twitter: UIButton!
    @IBOutlet weak var facebook: UIButton!
    @IBOutlet weak var instagram: UIButton!
    @IBOutlet weak var linkedin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        twitter.layer.cornerRadius = 10
        twitter.clipsToBounds = true
        instagram.layer.cornerRadius = 10
        instagram.clipsToBounds = true
        facebook.layer.cornerRadius = 10
        facebook.clipsToBounds = true
        linkedin.layer.cornerRadius = 10
        linkedin.clipsToBounds = true
    }

    @IBAction func facebookLoginButtonPressed(_ sender: Any) {
        let fbLoginManager : LoginManager = LoginManager()
        fbLoginManager.logIn(permissions: ["email"], from: self) { (result, error) -> Void in
            if (error == nil){
                let fbloginresult : LoginManagerLoginResult = result!
              // if user cancel the login
              if (result?.isCancelled)!{
                      return
              }
              if(fbloginresult.grantedPermissions.contains("email"))
              {
                self.getFBUserData()
              }
            }
        }
              
    }
    
    func getFBUserData(){
        if((AccessToken.current) != nil){
            GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
          if (error == nil){
            //everything works print the user data
            print(result)
          }
        })
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


