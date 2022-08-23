//
//  UserTableViewCell.swift
//  WorkingWithJSON
//
//  Created by admin on 23/08/2022.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    
    var userModel = UserModel() {
        didSet {
            self.fetchData(with: self.userModel)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private func fetchData(with data: UserModel) {
        data.name = (data.name == "") ? "Người dùng" : data.name
        self.userNameLabel.text = data.name
        self.userEmailLabel.text = (data.email == "") ? data.phone : data.email
    }
}
