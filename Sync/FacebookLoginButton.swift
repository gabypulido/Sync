//
//  FacebookLoginButton.swift
//  Sync
//
//  Created by Gabriela Pulido on 11/2/20.
//  Copyright © 2020 Gabriela Pulido. All rights reserved.
//

import Foundation
import UIKit
import FBSDKLoginKit

class FacebookLoginButton {
    
    var loginCompletionHandler: ((FacebookLoginButton, Result<LoginManagerLoginResult, Error>) -> Void)?
    var logoutCompletionHandler: ((FacebookLoginButton) -> Void)?
    private weak var responsibleViewController: UIViewController!
    
    private func commonSetup(){
//        responsibleViewController = findResponsibleViewController()
//
//        addTarget(self, action: #selector(touchUpInside(sender:)), for: .touchUpInside)
    }
    
//     public init(frame: CGRect) {
//        init(frame: frame)
//        commonSetup()
//    }
//
//    required public init?(coder aDecoder: NSCoder) {
//        init(coder: aDecoder)
//        commonSetup()
//    }
    
     private func touchUpInside(sender: FacebookLoginButton) {
        
        let loginManager = LoginManager()
        
        if let _ = AccessToken.current {
            // Access token available -- user already logged in
            // Perform log out
            
            loginManager.logOut()
            //updateButton(isLoggedIn: false)
            
            // 1
            // Trigger logout completed handler
            logoutCompletionHandler?(self)
            
        } else {
            // Access token not available -- user already logged out
            // Perform log in
            
            // 2
            loginManager.logIn(permissions: [], from: responsibleViewController) { [weak self] (result, error) in
                
                // 3
                // Check for error
                guard error == nil else {
                    // Error occurred
                    print(error!.localizedDescription)
                    
                    if let self = self {
                        self.loginCompletionHandler?(self, .failure(error!))
                    }
                    
                    return
                }
                
                // Check for cancel
                guard let result = result, !result.isCancelled else {
                    print("User cancelled login")
                    return
                }
                
                // Successfully logged in
                //self?.updateButton(isLoggedIn: true)
                
                // 4
                // Trigger login completed handler
                if let self = self {
                    self.loginCompletionHandler?(self, .success(result))
                }
            }
        }
    }
}
