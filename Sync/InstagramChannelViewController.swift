//
//  InstagramChannelViewController.swift
//  Sync
//
//  Created by Gabriela Pulido on 10/20/20.
//  Copyright © 2020 Gabriela Pulido. All rights reserved.
//

import UIKit

class InstagramChannelViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var instagramNotifications: [Notification] = []
    
    @IBOutlet weak var instagramNotificationTable: UITableView!{
        didSet {
            instagramNotificationTable.dataSource = self
            instagramNotificationTable.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        instagramNotificationTable.backgroundColor = UIColor(hue: 0.5222, saturation: 0.22, brightness: 0.87, alpha: 1.0)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return instagramNotifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell") as! SocialMediaTableViewCell
        cell.backgroundColor = UIColor(hue: 0.5222, saturation: 0.22, brightness: 0.87, alpha: 1.0)
        cell.socialIcon.image = UIImage(named: "instagram-64")
        return cell
    }
}
