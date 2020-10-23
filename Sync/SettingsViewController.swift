//
//  SettingsViewController.swift
//  Sync
//
//  Created by Audrey Chung on 10/22/20.
//  Copyright © 2020 Gabriela Pulido. All rights reserved.
//

import UIKit

enum MenuType: Int {
    case This
    case Should
    case Not
    case Happen
    case addSocial
    case passReset
}

class SettingsViewController: UITableViewController {

    var didTapMenuType: ((MenuType) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let menuType = MenuType(rawValue: indexPath.row) else { return }
        dismiss(animated: true) { [weak self] in
            self?.didTapMenuType?(menuType)
        }
    }

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "SegueChangePass", let nextVC = segue.destination  as? ChangePasswordViewController{
//            
//        } else if segue.identifier == "SegueSocial", let nextVC = segue.destination  as? OptInViewController{
//            
//        }
//    }

}
