//
//  AccountViewController.swift
//  Movie DB
//
//  Created by Varsha Soni on 30/06/25.
//

import UIKit

class AccountViewController: UIViewController {
    
    let accountViewModel = AccountViewModel()
   
    @IBOutlet weak var uitabelView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uitabelView.dataSource = self
        uitabelView.delegate = self
        uitabelView.sectionHeaderTopPadding = 24

    }
}

extension AccountViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        accountViewModel.numberOfRows(section: section)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        accountViewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = accountViewModel.sections[indexPath.section]
        switch section {
        case .userName:
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfileUserNameTableViewCell.reuseIdentifier) as! ProfileUserNameTableViewCell
            
            cell.nameLabel.text = "DeluxeAlonso"
            cell.subnameLabel.text = "Alonso Alverez"
               return cell
        case .watchlist(let watchList):
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileListCell")!
            let group = watchList[indexPath.row]
            cell.textLabel?.text = group.title
            cell.accessoryType = .disclosureIndicator
            return cell
        case .recommondations(let recommendation):
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileListCell")!
            let group = recommendation[indexPath.row]
            cell.textLabel?.text = group.title
            cell.accessoryType = .disclosureIndicator
            return cell
        case .createdList(let createdList):
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileListCell")!
            let group = createdList[indexPath.row]
            cell.textLabel?.text = group.title
            cell.accessoryType = .disclosureIndicator
            return cell
        case .signout:
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfileSignOutTableViewCell.identifier) as! ProfileSignOutTableViewCell
            cell.signoutLabel.text = "Sign Out"
               return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        accountViewModel.headerTitle(section: section)
    }

}

extension AccountViewController: UITableViewDelegate {
    
}
