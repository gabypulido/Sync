////
////  FacebookLoginButton.swift
////  Sync
////
////  Created by Gabriela Pulido on 11/2/20.
////  Copyright © 2020 Gabriela Pulido. All rights reserved.
////
//
//import Foundation
//import UIKit
//import FBSDKLoginKit
//
//class FacebookLoginButton {
//
//    @IBAction func loginFacebookAction(sender: AnyObject) {//action of the custom button in the storyboard
//        let fbLoginManager : LoginManager = LoginManager()
//        fbLoginManager.logIn(permissions: ["email"], from: self) { (result, Error?)
//            -> Void in
//        }
//          if (error == nil){
//            let fbloginresult : LoginManagerLoginResult = result!
//            // if user cancel the login
//            if (result?.isCancelled)!{
//                    return
//            }
//            if(fbloginresult.grantedPermissions.contains("email"))
//            {
//              self.getFBUserData()
//            }
//          }
//        }
//
//    func getFBUserData(){
//      if((AccessToken.current) != nil){
//          GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
//          if (error == nil){
//            //everything works print the user data
//            print(result)
//          }
//        })
//      }
//}
//      }
//
