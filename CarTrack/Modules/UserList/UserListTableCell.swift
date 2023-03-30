//
//  UserListTableCell.swift
//  CarTrack
//
//  Created by Shubham Raj on 27/03/23.
//

import UIKit

final class UserListTableCell: UITableViewCell {

    static let reuseIdentifier = "UserListTableCell"
    
    //MARK: - IBOutlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userImageV: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    var viewModel: UserListCellVM? {
        didSet {
            nameLabel.text = viewModel?.name
            usernameLabel.text = viewModel?.username
        }
    }
}
