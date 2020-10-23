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

class NotificationHubViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITableViewDragDelegate {
    
    var twitterNotifications = [Notification(body: "Twitter Test 1", time: "1"), Notification(body: "Twitter Test 1", time: "2"), Notification(body: "Twitter Test 3", time: "3")]
    
    var instagramNotifications = [Notification(body: "Instagram Test 1", time: "1"), Notification(body: "Instagram Test 2", time: "2"), Notification(body: "Instagram Test 3", time: "3")]
    
    var linkedInNotifications = [Notification(body: "LinkedIn Test 1", time: "1"), Notification(body: "LinkedIn Test 2", time: "2"), Notification(body: "LinkedIn Test 3", time: "3")]
    
    var facebookNotifications = [Notification(body: "Facebook Test 1", time: "1"), Notification(body: "Facebook Test 2", time: "2"), Notification(body: "Facebook Test 3", time: "3")]
    
    var sections = [Category]()
    
    let transiton = MenuTransition()
    var topView: UIView?
    
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
        sections = [Category(name: "Twitter", items: twitterNotifications), Category(name: "Instagram", items: instagramNotifications), Category(name: "LinkedIn", items: linkedInNotifications), Category(name: "Facebook", items: facebookNotifications)]
        notificationHubTable.backgroundColor = UIColor(hue: 0.6167, saturation: 0.17, brightness: 0.44, alpha: 1.0)
        self.view.backgroundColor = UIColor(hue: 0.6167, saturation: 0.17, brightness: 0.44, alpha: 1.0)
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell") as! SocialMediaTableViewCell
        let items = self.sections[indexPath.section].items
        cell.backgroundColor = UIColor(hue: 0.5222, saturation: 0.22, brightness: 0.87, alpha: 1.0)
        switch sections[indexPath.section].name {
            case "Twitter":
                cell.socialIcon.image = UIImage(named: "twitter-64")
            case "Instagram":
                cell.socialIcon.image = UIImage(named: "instagram-64")
            case "LinkedIn":
                cell.socialIcon.image = UIImage(named: "linkedin-3-64")
            case "Facebook":
                cell.socialIcon.image = UIImage(named: "facebook-3-64")
            default:
                print("Error")
        }
        
        return cell
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        switch sections[indexPath.section].name {
        case "Twitter":
            self.performSegue(withIdentifier: "TwitterChannelSegue", sender: self)
        case "Instagram":
            self.performSegue(withIdentifier: "InstagramChannelSegue", sender: self)
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
    
    //TODO: Figure out drag and drop sections
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
    
    @IBAction func hamTapped(_ sender: Any) {
        guard let settingsViewController = storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as? SettingsViewController else { return }
        settingsViewController.didTapMenuType = { menuType in
            self.transitionToNew(menuType)
        }
        settingsViewController.modalPresentationStyle = .overCurrentContext
        settingsViewController.transitioningDelegate = self
        present(settingsViewController, animated: true)
    }

    func transitionToNew(_ menuType: MenuType) {

        topView?.removeFromSuperview()
        switch menuType {
        case .addSocial:
            let socialVC = OptInViewController()
            view.addSubview(socialVC.view)
            self.topView = socialVC.view
            addChildViewController(socialVC)
            
//            let view = UIView()
//            view.frame = self.view.bounds
//            self.view.addSubview(view)
//            self.topView = view
        case .passReset:
            let view = UIView()
            view.frame = self.view.bounds
            self.view.addSubview(view)
            self.topView = view
        default:
            break
        }
    }

}

extension NotificationHubViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = true
        return transiton
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = false
        return transiton
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier{
        case "TwitterChannelSegue":
            let nextVC = segue.destination as? TwitterChannelViewController
            nextVC?.twitterNotifications = sections[0].items
        case "InstagramChannelSegue":
            let nextVC = segue.destination as? InstagramChannelViewController
            nextVC?.instagramNotifications = sections[1].items
        case "LinkedInChannelSegue":
            let nextVC = segue.destination as? LinkedInChannelViewController
            nextVC?.linkedInNotifications = sections[2].items
        case "FacebookChannelSegue":
            let nextVC = segue.destination as? FacebookChannelViewController
            nextVC?.facebookNotifications = sections[3].items
        default:
            print("error")
        }
    }

}
