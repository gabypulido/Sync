//
//  SettingsViewController.swift
//  Sync
//
//  Created by Audrey Chung on 10/22/20.
//  Copyright © 2020 Gabriela Pulido. All rights reserved.
//

import UIKit

enum MenuType: String {
    case profile
    case optInTitle
    case socialOptIns
    case addSocial
    case passReset
}

public let dataSource = [ "Sync Test","Social Media Opt In", "@Sync", "Add a Service +", "Change Password"]

class FirstTableCell: UITableViewCell {
    @IBOutlet weak var profPic: UIImageView!
    @IBOutlet weak var username: UILabel!
}

class SecondTableCell: UITableViewCell {
    @IBOutlet weak var txtLbl: UILabel!
}

class ThirdTableCell: UITableViewCell {
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var profileTag: UILabel!
}

class FourthTableCell: UITableViewCell {
    @IBOutlet weak var addServiceLabel: UILabel!
}

class SettingsViewController: UITableViewController {
    
    var didTapMenuType: ((MenuType) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 68.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return UITableViewAutomaticDimension
    }
    
    //    instead of making a new cell everytime, you deque a reusable one.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
           let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell") as! FirstTableCell
            cell.profPic.sizeToFit()
            cell.username.text = dataSource[0]
            cell.username.sizeToFit()
           return cell
        } else if indexPath.row == 1 {
           let cell = tableView.dequeueReusableCell(withIdentifier: "changePassCell") as! SecondTableCell
            cell.txtLbl.text = dataSource[1]
            cell.txtLbl.sizeToFit()
            cell.isUserInteractionEnabled = false
           return cell
        } else if indexPath.row ==  dataSource.count - 2 {
           let cell = tableView.dequeueReusableCell(withIdentifier: "optInCell") as! FourthTableCell
            cell.addServiceLabel.text = dataSource[dataSource.count - 2]
            cell.addServiceLabel.sizeToFit()
           return cell
        } else if indexPath.row ==  dataSource.count - 1 {
           let cell = tableView.dequeueReusableCell(withIdentifier: "changePassCell") as! SecondTableCell
            cell.txtLbl.text = dataSource[dataSource.count - 1]
            cell.txtLbl.sizeToFit()
           return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "twittercell") as! ThirdTableCell
            cell.icon.image = UIImage(named: "twitter-64")
            //cell.icon.sizeToFit()
            cell.profileTag.text = dataSource[indexPath.row]
            cell.profileTag.sizeToFit()
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {        
        var menuType: MenuType!

        if indexPath.row == dataSource.count - 2 {
            menuType = MenuType.addSocial
        } else if indexPath.row == dataSource.count - 1 {
            menuType = MenuType.passReset
        } else {
            return
        }
        
        dismiss(animated: false) { [weak self] in
            print("Dismissing: \(menuType)")
            self?.didTapMenuType?(menuType)
        }
    }

}
