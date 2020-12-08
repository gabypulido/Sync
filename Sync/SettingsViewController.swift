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

 var darkM = 0

public var dataSource = [ "Sync Test", "Dark Mode","Social Media Opt In", "@Sync", "Add a Service +", "Change Password"]

public var profImage = UIImage(named: "120620519_777256209718165_3142639425989673168_n.jpg")

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

class DarkMCell: UITableViewCell {
    @IBOutlet weak var darkMLabel: UILabel!
    @IBOutlet weak var darkMToggle: UISwitch!
}

class SettingsViewController: UITableViewController {
    
    var didTapMenuType: ((MenuType) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
           return CGFloat(241)
        } else if indexPath.row == 1 {
            return CGFloat(81)
        } else if indexPath.row == 2 {
           return CGFloat(81)
        } else if indexPath.row ==  dataSource.count - 2 {
           return CGFloat(50)
        } else if indexPath.row ==  dataSource.count - 1 {
           return CGFloat(81)
        } else {
            return CGFloat(50)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    //tried adding gesture recognition & would not work
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
           let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell") as! FirstTableCell
            cell.profPic.image = profImage
            let recognizer = UITapGestureRecognizer(target: self, action: #selector(tapProfilePic(recognizer:)))
            recognizer.numberOfTapsRequired = 1
            cell.profPic.addGestureRecognizer(recognizer)
            cell.profPic.tag = indexPath.row
            cell.profPic.isUserInteractionEnabled = true;
            
            cell.profPic.layer.masksToBounds = true
            cell.profPic.layer.borderWidth = 2
            cell.profPic.layer.borderColor = UIColor(red: (251/255), green: (242/255), blue: (217/255), alpha: 1).cgColor
            //cell.profPic.layer.borderColor = UIColor.red.cgColor
            cell.profPic.layer.cornerRadius = cell.profPic.frame.width/2.0
            
            cell.username.text = dataSource[0]
            cell.username.sizeToFit()
            let gesture = UITapGestureRecognizer(target: self, action: #selector(tapUsername(recognizer:)))
            gesture.numberOfTapsRequired = 1
            cell.username.addGestureRecognizer(gesture)
            cell.username.tag = indexPath.row
            cell.username.isUserInteractionEnabled = true;
           return cell
        } else if indexPath.row == 1 {
                  let cell = tableView.dequeueReusableCell(withIdentifier: "darkModeCell") as! DarkMCell
            cell.darkMLabel.text = dataSource[1]
            cell.darkMLabel.sizeToFit()
            cell.darkMToggle.isUserInteractionEnabled = true
            
            if darkM == 1 {
                cell.darkMToggle.setOn(true, animated: false)
            } else {
                cell.darkMToggle.setOn(false, animated: false)
            }
            return cell
        } else if indexPath.row == 2 {
           let cell = tableView.dequeueReusableCell(withIdentifier: "changePassCell") as! SecondTableCell
            cell.txtLbl.text = dataSource[2]
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
    
    @IBAction func switchToggled(_ sender: Any) {
        let indexPath = IndexPath(row: 1, section: 0)
        let cell = tableView.cellForRow(at: indexPath) as! DarkMCell
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if cell.darkMToggle.isOn {
            darkM = 1
            appDelegate.window!.overrideUserInterfaceStyle = .dark
        } else {
            darkM = 0
            appDelegate.window!.overrideUserInterfaceStyle = .light
        }
         
    }
    //            if acsessabilitySwitch.on {
//    //accessibilitySwitch is the UISwitch in question
//                println("It's True!")
//                advice.isInProduction = Bool (true)
//    // isInProduction is a attribute of a class
//            } else {
//                println("It's False!")
//                advice.isInProduction = Bool (false)
//            }
    
    @objc func tapProfilePic(recognizer: UITapGestureRecognizer) {
        if recognizer.state == UIGestureRecognizerState.ended {
                presentPhotoActionSheet()
        }
    }
    
    @objc func tapUsername(recognizer: UITapGestureRecognizer) {
        if recognizer.state == UIGestureRecognizerState.ended {
                changeProfName()
        }
    }

    func changeProfName() {
        let alertController = UIAlertController(title: "Change Username", message: nil, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Submit", style: .default) { (_) in
            let indexPath = IndexPath(row: 0, section: 0)
            let cell = self.tableView.cellForRow(at: indexPath) as! FirstTableCell
            cell.username.text = alertController.textFields?.first?.text
            dataSource[0] = (alertController.textFields?.first?.text)!
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter New Username"
        }
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
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

extension SettingsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func presentPhotoActionSheet(){
        let actionSheet = UIAlertController(title: "Profile Picture", message: "Select new profile picture", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel",
                                            style: .cancel,
                                            handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Take Photo",
                                            style: .default,
                                            handler: { [weak self] _ in
                                                self?.presentCamera()
        }))
        actionSheet.addAction(UIAlertAction(title: "Choose Photo",
                                            style: .default,
                                            handler: { [weak self] _ in
                                                self?.presentPhotoPicker()
        }))
        
        present(actionSheet, animated: true)
        
    }
    
    func presentCamera(){
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    func presentPhotoPicker(){
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
  
    //once image is selected, replace profile pic
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerEditedImage] as? UIImage else {
            return
        }
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = tableView.cellForRow(at: indexPath) as! FirstTableCell

        profImage = image
        cell.profPic.image = image
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

