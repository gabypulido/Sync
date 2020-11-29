//
//  TwitterChannelViewController.swift
//  Sync
//
//  Created by Gabriela Pulido on 10/20/20.
//  Copyright © 2020 Gabriela Pulido. All rights reserved.
//

import UIKit
import DropDown

class TwitterChannelViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var twitterNotificationTable: UITableView!{
        didSet {
            twitterNotificationTable.dataSource = self
            twitterNotificationTable.delegate = self
        }
    }
    
    var delegate: UIViewController!
    //var notifications: [Notification]!
    let dropDown = DropDown()
    var filterType = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        twitterNotificationTable.backgroundColor = UIColor(hue: 0.5222, saturation: 0.22, brightness: 0.87, alpha: 1.0)
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //change to number of notifs
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell") as! UITableViewCell
        cell.backgroundColor = UIColor(hue: 0.5222, saturation: 0.22, brightness: 0.87, alpha: 1.0)
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
            }
    }

}
