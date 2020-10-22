//
//  FacebookChannelViewController.swift
//  Sync
//
//  Created by Gabriela Pulido on 10/20/20.
//  Copyright © 2020 Gabriela Pulido. All rights reserved.
//

import UIKit

class FacebookChannelViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var facebookNotifications: [Notification] = []
    
    @IBOutlet weak var facebookNotificationTable: UITableView!{
        didSet {
            facebookNotificationTable.dataSource = self
            facebookNotificationTable.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        facebookNotificationTable.backgroundColor = UIColor(hue: 0.5222, saturation: 0.22, brightness: 0.87, alpha: 1.0)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return facebookNotifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell") as! SocialMediaTableViewCell
        cell.backgroundColor = UIColor(hue: 0.5222, saturation: 0.22, brightness: 0.87, alpha: 1.0)
        cell.socialIcon.image = UIImage(named: "facebook-3-64")
        return cell
    }
}
