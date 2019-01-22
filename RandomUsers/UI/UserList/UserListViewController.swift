//
//  UserListViewController.swift
//  RandomUsers
//
//  Created by  Oleksandra on 1/21/19.
//  Copyright © 2019 sandra-alt. All rights reserved.
//

import UIKit

class UserListViewController: UITableViewController {

    private var users = [User]()
    private var currentPage = 1
    
    private let userCellName = "UserListCell"
    private let loadingCellName = "LoadingCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.clearsSelectionOnViewWillAppear = false

        let userNib = UINib(nibName: userCellName, bundle: nil)
        tableView.register(userNib, forCellReuseIdentifier:userCellName)
        
        let loadingCellNib = UINib(nibName: "LoadingCell", bundle: nil)
        tableView.register(loadingCellNib, forCellReuseIdentifier: loadingCellName)
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func loadUsers() {
        let ns = NetworkService()
        ns.fetchUsers(forPage: currentPage, completion: { (users) in
            DispatchQueue.main.async {
                self.users.append(contentsOf: users!)
                self.tableView.reloadData()
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count + 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.row == users.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: loadingCellName, for: indexPath) as! LoadingCell
            cell.activityIndicator.startAnimating()
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: userCellName, for: indexPath) as! UserListCell
            cell.configureCellFor(user: users[indexPath.row])
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView.contentOffset.y >= (tableView.contentSize.height - tableView.frame.size.height) {
            loadUsers()
            currentPage += 1
        }
    }
    

    // MARK: - Navigation

    private let segueIdentifier = "ShowUserDescription"
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: segueIdentifier, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier {
        }
    }

}
