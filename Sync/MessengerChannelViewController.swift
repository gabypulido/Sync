//
//  MessengerChannelViewController.swift
//  Sync
//
//  Created by Gabriela Pulido on 10/20/20.
//  Copyright © 2020 Gabriela Pulido. All rights reserved.
//

import UIKit

class MessengerChannelViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var instagramNotificationTable: UITableView!{
        didSet {
            instagramNotificationTable.dataSource = self
            instagramNotificationTable.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        instagramNotificationTable.backgroundColor = UIColor(hue: 0.5222, saturation: 0.22, brightness: 0.87, alpha: 1.0)
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //change to number of notifs
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell") as! SocialMediaTableViewCell
        cell.backgroundColor = UIColor(hue: 0.5222, saturation: 0.22, brightness: 0.87, alpha: 1.0)
        cell.socialIcon.image = UIImage(named: "instagram-64")
        return cell
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
