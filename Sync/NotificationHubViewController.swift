//
//  NotificationHubViewController.swift
//  Sync
//
//  Created by Gabriela Pulido on 10/19/20.
//  Copyright © 2020 Gabriela Pulido. All rights reserved.
//

import UIKit

class SocialMediaTableViewCell: UITableViewCell {
    @IBOutlet weak var socialMediaNameLabel: UILabel!
    
}

class NotificationHubViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var socialMedia: [String] = ["Twitter", "Messenger", "LinkedIn", "Facebook", ]
    @IBOutlet weak var notificationHubTable: UITableView!{
        didSet {
                notificationHubTable.dataSource = self
                notificationHubTable.delegate = self
            }
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableCell.backgroundColor = UIColor(hue: 0.5222, saturation: 0.22, brightness: 0.87, alpha: 1.0)
        // Do any additional setup after loading the view.
        notificationHubTable.backgroundColor = UIColor(hue: 0.5222, saturation: 0.22, brightness: 0.87, alpha: 1.0)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return socialMedia.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! SocialMediaTableViewCell
        cell.backgroundColor = UIColor(hue: 0.5222, saturation: 0.22, brightness: 0.87, alpha: 1.0)
        let row = indexPath.row
        let socialMediaNetwork = socialMedia[row]
        cell.socialMediaNameLabel.text = socialMediaNetwork

        return cell
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        switch socialMedia[indexPath.row] {
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
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
