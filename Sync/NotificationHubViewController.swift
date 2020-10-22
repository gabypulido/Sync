//
//  NotificationHubViewController.swift
//  Sync
//
//  Created by Gabriela Pulido on 10/19/20.
//  Copyright © 2020 Gabriela Pulido. All rights reserved.
//

import UIKit

struct Category {
   let name : String
   var items : [Notification]
}

struct Notification {
    var body = String()
    var time = String()
}

class SocialMediaTableViewCell: UITableViewCell {
    @IBOutlet weak var socialMediaNameLabel: UILabel!
    
}

class NotificationHubViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITableViewDragDelegate {
    
    var socialMedia: [String] = ["Twitter", "Messenger", "LinkedIn", "Facebook", ]
    var twitterNotifications = [Notification(body: "Twitter Test", time: "time")]
    var messengerNotifications = [Notification(body: "Messenger Test", time: "time")]
    var linkedInNotifications = [Notification(body: "LinkedIn Test", time: "time")]
    var facebookNotifications = [Notification(body: "Facebook Test", time: "time")]
    
    var sections = [Category]()
    
    @IBOutlet weak var notificationHubTable: UITableView!{
        didSet {
            notificationHubTable.dataSource = self
            notificationHubTable.delegate = self
            notificationHubTable.dragDelegate = self
            notificationHubTable.dragInteractionEnabled = true
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //tableCell.backgroundColor = UIColor(hue: 0.5222, saturation: 0.22, brightness: 0.87, alpha: 1.0)
        // Do any additional setup after loading the view.
        sections = [Category(name: "Twitter", items: twitterNotifications), Category(name: "Messenger", items: messengerNotifications), Category(name: "LinkedIn", items: linkedInNotifications), Category(name: "Facebook", items: facebookNotifications)]
        notificationHubTable.backgroundColor = UIColor(hue: 0.6167, saturation: 0.17, brightness: 0.44, alpha: 1.0)
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! SocialMediaTableViewCell
//        cell.backgroundColor = UIColor(hue: 0.5222, saturation: 0.22, brightness: 0.87, alpha: 1.0)
//        let row = indexPath.row
//        let socialMediaNetwork = socialMedia[row]
//        cell.socialMediaNameLabel.text = socialMediaNetwork
//
//        return cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell") as! SocialMediaTableViewCell
        let items = self.sections[indexPath.section].items
        //let item = items[indexPath.row]
        cell.backgroundColor = UIColor(hue: 0.5222, saturation: 0.22, brightness: 0.87, alpha: 1.0)
        return cell
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        switch sections[indexPath.section].name {
        case "Twitter":
                self.performSegue(withIdentifier: "TwitterChannelSegue", sender: self)
        case "Messenger":
            self.performSegue(withIdentifier: "MessengerChannelSegue", sender: self)
        case "LinkedIn":
            self.performSegue(withIdentifier: "LinkedInChannelSegue", sender: self)
        case "Facebook":
            self.performSegue(withIdentifier: "FacebookChannelSegue", sender: self)
            default:
                print("default")
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sections[section].name
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor(hue: 0.6167, saturation: 0.17, brightness: 0.44, alpha: 1.0)
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor(hue: 0.125, saturation: 0.11, brightness: 0.98, alpha: 1.0)
    }
    
    //TODO: Figure out drag and drop 
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let dragItem = UIDragItem(itemProvider: NSItemProvider())
        dragItem.localObject = self.sections[indexPath.section]
        return [ dragItem ]
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        // Update the model
        let mover = self.sections.remove(at: sourceIndexPath.section)
        self.sections.insert(mover, at: destinationIndexPath.section)
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
