//
//  TwitterChannelViewController.swift
//  Sync
//
//  Created by Gabriela Pulido on 10/20/20.
//  Copyright © 2020 Gabriela Pulido. All rights reserved.
//

import UIKit
import DropDown
import CoreData

class TwitterTableViewCell: UITableViewCell {
    @IBOutlet weak var socialIcon: UIImageView!
    @IBOutlet weak var notificationType: UILabel!
    @IBOutlet weak var notificationBody: UILabel!
    @IBOutlet weak var notificationTime: UILabel!
}

class TwitterChannelViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var twitterNotificationTable: UITableView!{
        didSet {
            twitterNotificationTable.dataSource = self
            twitterNotificationTable.delegate = self
        }
    }
    
    var delegate: UIViewController!
    var fullNotifications: [NSManagedObject]!
    let dropDown = DropDown()
    var count = 0;
    var filterType = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        twitterNotificationTable.backgroundColor = UIColor(named: "blueButton")
        
        let mainVC = NotificationHubViewController()
        self.fullNotifications = mainVC.retrieveNotifications()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterNotifications().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! TwitterTableViewCell
        cell.backgroundColor = UIColor(named: "blueButton")
        let row = indexPath.row
        let currNotification = filterNotifications()[row]
        
        cell.socialIcon.image = UIImage(named: "twitter-64")
        cell.notificationBody.text = currNotification.value(forKey: "notificationContent") as? String
        cell.notificationType.text = currNotification.value(forKey: "notificationType") as? String
        cell.notificationTime.text = currNotification.value(forKey: "time") as? String
        
        return cell
    }
    
    @IBAction func chooseType(_ sender: Any) {
        dropDown.dataSource = ["All", "Retweet", "Mention", "Direct Message"]
        dropDown.anchorView = (sender as! AnchorView)
        dropDown.bottomOffset = CGPoint(x: 0, y: (sender as AnyObject).frame.size.height)
        dropDown.show()
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            guard let _ = self else { return }
            (sender as AnyObject).setTitle(item, for: .normal)
            self!.filterType = item
            self!.twitterNotificationTable.reloadData()
        }
    }
    
    func filterNotifications() -> [NSManagedObject] {
        switch self.filterType {
            case "Retweet":
                return fullNotifications.filter{ $0.value(forKey: "notificationType") as? String == ("Retweet") }
            case "Mention":
                return fullNotifications.filter{ $0.value(forKey: "notificationType") as? String == ("Mention") }
            case "Direct Message":
                return fullNotifications.filter{ $0.value(forKey: "notificationType") as? String == ("Direct Message") }
            default:
                return fullNotifications
        }
    }

}
