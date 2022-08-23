//
//  FirstViewController.swift
//  WorkingWithJSON
//
//  Created by admin on 22/08/2022.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var listUser = [UserModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configTableView()
        self.fetchUserData()
    }
    
    // MARK: - Setup:
    private func configTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.tableView.registerCell(ofType: UserTableViewCell.self)
    }
    //MARK: - Helpers:
    private func fetchUserData() {
        self.showHUD()
        ResponseData.shared.getUser { [weak self] (data) in
            guard let `self` = self else { return }
            self.listUser = data
            DispatchQueue.main.async {
                self.hideHUD()
                self.tableView.reloadData()
            }
        }
    }
}

// MARK: - UITableViewDelegate
extension FirstViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - UITableViewDataSource
extension FirstViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listUser.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(ofType: UserTableViewCell.self)
        cell.userModel = self.listUser[indexPath.row]
        return cell
    }
}
