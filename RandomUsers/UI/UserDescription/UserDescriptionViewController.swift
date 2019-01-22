//
//  UserDescriptionViewController.swift
//  RandomUsers
//
//  Created by  Oleksandra on 1/22/19.
//  Copyright © 2019 sandra-alt. All rights reserved.
//

import UIKit

protocol ReachOutDelegate: class {
    func callNumber(phoneNumber: String)
}

class UserDescriptionViewController: UITableViewController, ReachOutDelegate {

    private let pictureCellName = "UserPictureCell"
    private let contactCellName = "ContactInfoCell"
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pictureCellNib = UINib(nibName: pictureCellName, bundle: nil)
        tableView.register(pictureCellNib, forCellReuseIdentifier: pictureCellName)
        
        let contactCellNib = UINib(nibName: contactCellName, bundle: nil)
        tableView.register(contactCellNib, forCellReuseIdentifier: contactCellName)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: pictureCellName, for: indexPath) as! UserPictureCell
            cell.configureCellFor(user: user!)
            return cell
        } else {
            let contactCell = tableView.dequeueReusableCell(withIdentifier: contactCellName, for: indexPath) as! ContactInfoCell
            switch indexPath.row {
            case 1:
                contactCell.configureCellFor(info: user!.phone, type: .phone)
            case 2:
                contactCell.configureCellFor(info: user!.cell, type: .cellPhone)
            default:
                contactCell.configureCellFor(info: user!.email, type: .email)
            }
            contactCell.delegate = self
            return contactCell
        }
    }
    
    //MARK: - ReachOut Delegate
    
    func callNumber(phoneNumber:String) {
        let alertController = UIAlertController(title: phoneNumber, message: "Would you like to make a call?", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
        alertController.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
            if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
                
                let application:UIApplication = UIApplication.shared
                if (application.canOpenURL(phoneCallURL)) {
                    application.open(phoneCallURL, options: [:], completionHandler: nil)
                }
            }
        }))
        present(alertController, animated: true, completion:{})
        return
    }
}
