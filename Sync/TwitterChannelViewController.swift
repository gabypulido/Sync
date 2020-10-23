//
//  TwitterChannelViewController.swift
//  Sync
//
//  Created by Gabriela Pulido on 10/20/20.
//  Copyright © 2020 Gabriela Pulido. All rights reserved.
//

import UIKit

class TwitterChannelViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var twitterNotifications: [Notification] = []
    var delegate: UIViewController!
    
    @IBOutlet weak var twitterNotificationTable: UITableView!{
        didSet {
            twitterNotificationTable.dataSource = self
            twitterNotificationTable.delegate = self
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return twitterNotifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell") as! SocialMediaTableViewCell
        cell.backgroundColor = UIColor(hue: 0.5222, saturation: 0.22, brightness: 0.87, alpha: 1.0)
        cell.socialIcon.image = UIImage(named: "twitter-64")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
       tableView.deselectRow(at: indexPath, animated: true)
   }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        twitterNotificationTable.backgroundColor = UIColor(hue: 0.5222, saturation: 0.22, brightness: 0.87, alpha: 1.0)
    }
}
