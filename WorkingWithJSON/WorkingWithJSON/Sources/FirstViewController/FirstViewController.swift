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
    var isLoadMore = false
    var currentPage = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configTableView()
        self.fetchUserData(with: 10, and: self.currentPage)
    }
    
    // MARK: - Setup:
    private func configTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.tableView.registerCell(ofType: UserTableViewCell.self)
    }
    //MARK: - Helpers:
    private func fetchUserData(with limit: Int, and page: Int) {
        self.isLoadMore = true
        self.showHUD()
        ResponseData.shared.getUser(page: self.currentPage, limit: 10) { [weak self] (data) in
            guard let `self` = self else { return }
            if data.count < limit {
                self.isLoadMore = false
            }
            if self.listUser.isEmpty {
                self.listUser = data
            } else {
                data.forEach( { self.listUser.append($0)})
            }
            
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

extension FirstViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {let bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height;
        if bottomEdge >= scrollView.contentSize.height {
            if self.isLoadMore {
                self.currentPage += 1
                self.fetchUserData(with: 10, and: self.currentPage)
            }
        }
    }
}
