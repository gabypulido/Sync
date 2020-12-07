//
//  OptInViewController.swift
//  Sync
//
//  Created by Maria Maynard on 10/21/20.
//  Copyright © 2020 Gabriela Pulido. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import SafariServices
import TwitterKit
import WebKit

class OptInViewController: UIViewController{
    
    @IBOutlet weak var twitter: UIButton!
    @IBOutlet weak var facebook: UIButton!
    @IBOutlet weak var instagram: UIButton!
    @IBOutlet weak var linkedin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    func requestForAccessToken(authorizationCode: String) {
        let linkedInKey = "786d9hwj2w5idg"
        let linkedInSecret = "kjPQr2j6J79FWYX4"
        let authorizationEndPoint = "https://www.linkedin.com/uas/oauth2/authorization"
        let accessTokenEndPoint = "https://www.linkedin.com/uas/oauth2/accessToken"
        let callBackUrl = "https://com.sync.linkedin.oauth/oauth"
        let grantType = "authorization_code"
        
        let redirectURL = "https://com.sync.linkedin.oauth/oauth".addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics)!
        
        // Set the POST parameters.
        var postParams = "grant_type=\(grantType)&"
        postParams += "code=\(authorizationCode)&"
        postParams += "redirect_uri=\(redirectURL)&"
        postParams += "client_id=\(linkedInKey)&"
        postParams += "client_secret=\(linkedInSecret)"
        
        
        // Convert the POST parameters into a NSData object.
        let postData = postParams.data(using: String.Encoding.utf8)
        
        // Initialize a mutable URL request object using the access token endpoint URL string.
        let request = NSMutableURLRequest(url: NSURL(string: accessTokenEndPoint)! as URL)
        
        // Indicate that we're about to make a POST request.
        request.httpMethod = "POST"
        
        // Set the HTTP body using the postData object created above.
        request.httpBody = postData
        // Add the required HTTP header field.
        request.addValue("application/x-www-form-urlencoded;", forHTTPHeaderField: "Content-Type")
        
        // Initialize a NSURLSession object.
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        // Make the request.
        let task: URLSessionDataTask = session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            // Get the HTTP status code of the request.
            let statusCode = (response as! HTTPURLResponse).statusCode
            
            if statusCode == 200 {
                // Convert the received JSON data into a dictionary.
                do {
                    let dataDictionary = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                    print("dataDictionary\(dataDictionary)")
                    let accessToken = dataDictionary["access_token"] as! String
                    
                    UserDefaults.standard.set(accessToken, forKey: "LIAccessToken")
                    UserDefaults.standard.synchronize()
                    print("START sentData")
                    DispatchQueue.main.async(execute: { () -> Void in
                        self.navigationController?.popViewController(animated: true)
                    })
                }
                catch {
                    print("Could not convert JSON data into a dictionary.")
                }
            }else{
                print("cancel clicked")
            }
        }
        
        task.resume()
        
    }
    
    /*LinkedIn logout*/
    func logout(){
        let revokeUrl = "https://api.linkedin.com/uas/oauth/invalidateToken"
        let request = URLRequest(url: URL(string: revokeUrl)!)
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
        
        if((TWTRTwitter.sharedInstance().sessionStore.session()?.userID) == nil){
            self.twitter.setTitle("Sign into Twitter", for: .normal)
        } else{
            self.twitter.setTitle("Log out of Twitter", for: .normal)
        }
    }
    
    @IBAction func linkedInLoginButtonPressed(_ sender: Any) {
        startLinkedInAuth()
        //self.view.addSubview(webView)
    }
    
    func startLinkedInAuth(){
        let linkedInKey = "786d9hwj2w5idg"
        let linkedInSecret = "kjPQr2j6J79FWYX4"
        let authorizationEndPoint = "https://www.linkedin.com/uas/oauth2/authorization"
        let accessTokenEndPoint = "https://www.linkedin.com/uas/oauth2/accessToken"
        let callBackUrl = "https://com.sync.linkedin.oauth/oauth"
        // Specify the response type which should always be "code".
        let responseType = "code"
        
        // Set the redirect URL which you have specify at time of creating application in LinkedIn Developer’s website. Adding the percent escape characthers is necessary.
        let redirectURL = callBackUrl.addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics)!
        
        // Create a random string based on the time interval (it will be in the form linkedin12345679).
        let state = "linkedin\(Date().timeIntervalSince1970)"
        
        // Set preferred scope.
        let scope = "r_emailaddress"
        // Create the authorization URL string.
        var authorizationURL = "\(authorizationEndPoint)?"
        authorizationURL += "response_type=\(responseType)&"
        authorizationURL += "client_id=\(linkedInKey)&"
        authorizationURL += "redirect_uri=\(redirectURL)&"
        authorizationURL += "state=\(state)&"
        authorizationURL += "scope=\(scope)"
        print(authorizationURL)
        
        logout()
        
        let link:URL = URL(string: authorizationURL)!
        let request = URLRequest(url: link)
//        webView = WKWebView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
//        webView.navigationDelegate = self
//        self.webView.load(request)
//        self.view.addSubview(webView)
        UIApplication.shared.open(link)
        print(request)
    }
    
    @IBAction func twitterLoginButtonPressed(_ sender: Any) {
        if((TWTRTwitter.sharedInstance().sessionStore.session()?.userID) == nil) {
            //show twitter login button
            TWTRTwitter.sharedInstance().logIn { session, error in
                if (session != nil) {
                    print("signed in as \(session!.userName)")
                    let client = TWTRAPIClient.withCurrentUser()
                    let request = client.urlRequest(withMethod: "GET",
                                                    urlString: "https://api.twitter.com/1.1/account/verify_credentials.json",
                                                    parameters: ["include_email": "true", "skip_status": "true"],
                                                    error: nil)
                    client.sendTwitterRequest(request)
                    { response, data, connectionError in
                        print(response)
                    }
                    self.twitter.setTitle("Log out of Twitter", for: .normal)
                } else {
                    print("error: \(error!.localizedDescription)");
                }
            }
            print("nil")
        } else {
            let store = TWTRTwitter.sharedInstance().sessionStore
            if let userID = store.session()?.userID {
                store.logOutUserID(userID)
            }
            self.twitter.setTitle("Sign into Twitter", for: .normal)
        }
    }
    
    @IBAction func facebookLoginButtonPressed(_ sender: Any) {
        let fbLoginManager : LoginManager = LoginManager()
        if(AccessToken.current == nil){
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
                        self.facebook.setTitle("Log out of Facebook", for: .normal)
                    }
                }
            }
        }else{
            fbLoginManager.logOut()
            self.facebook.setTitle("Sign into Facebook", for: .normal)
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


