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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
