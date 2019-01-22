//
//  UserDescriptionViewController.swift
//  RandomUsers
//
//  Created by  Oleksandra on 1/22/19.
//  Copyright © 2019 sandra-alt. All rights reserved.
//

import UIKit

class UserDescriptionViewController: UITableViewController {

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

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: pictureCellName, for: indexPath) as! UserPictureCell
            cell.configureCellFor(user: user!)
            return cell
        case 1:
            let contactCell = tableView.dequeueReusableCell(withIdentifier: contactCellName, for: indexPath) as! ContactInfoCell
            contactCell.contactButton.setTitle(user!.phone, for: .normal)
            contactCell.iconView.image = UIImage(named: "phone")
            return contactCell
        case 2:
            let contactCell = tableView.dequeueReusableCell(withIdentifier: contactCellName, for: indexPath) as! ContactInfoCell
            contactCell.contactButton.setTitle(user!.cell, for: .normal)
            contactCell.iconView.image = UIImage(named: "cell_phone")
            return contactCell
        case 3:
            let contactCell = tableView.dequeueReusableCell(withIdentifier: contactCellName, for: indexPath) as! ContactInfoCell
            contactCell.contactButton.setTitle(user!.email, for: .normal)
            contactCell.iconView.image = UIImage(named: "email")
            return contactCell
        default:
            return UITableViewCell()
        }

    }
}
