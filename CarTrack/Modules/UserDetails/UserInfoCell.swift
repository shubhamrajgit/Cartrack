//
//  UserInfoCell.swift
//  CarTrack
//
//  Created by Shubham Raj on 28/03/23.
//

import UIKit

final class UserInfoCell: UITableViewCell {

    static let reuseIdentifier = "UserInfoCell"
    
    //MARK: - IBOutlets
    @IBOutlet weak var userImageView: UIImageView!

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    
    @IBOutlet weak var emailLogo: UIImageView!
    @IBOutlet weak var phoneLogo: UIImageView!
    @IBOutlet weak var webLogo: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    var viewModel: UserInfoCellVM? {
        didSet {
            nameLabel.text = viewModel?.name
            usernameLabel.text = viewModel?.username
            emailLabel.text = viewModel?.email
            phoneLabel.text = viewModel?.phone
            websiteLabel.text = viewModel?.website
        }
    }
}
