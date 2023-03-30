//
//  UserCompanyCell.swift
//  CarTrack
//
//  Created by Shubham Raj on 28/03/23.
//

import UIKit

final class UserCompanyCell: UITableViewCell {

    static let reuseIdentifier = "UserCompanyCell"
    
    //MARK: - IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var catchPhraseLabel: UILabel!
    @IBOutlet weak var bsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    var viewModel: UserInfoCellVM? {
        didSet {
            titleLabel.text = viewModel?.getCompanyCellTitle()
            companyNameLabel.text = viewModel?.companyName
            catchPhraseLabel.text = viewModel?.catchPhrase
            bsLabel.text = viewModel?.bs
        }
    }
}
