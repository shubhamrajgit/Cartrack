//
//  UserAddressCell.swift
//  CarTrack
//
//  Created by Shubham Raj on 28/03/23.
//

import UIKit
import MapKit

final class UserAddressCell: UITableViewCell {

    static let reuseIdentifier = "UserAddressCell"
    
    //MARK: - IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var addressLogo: UIImageView!
    @IBOutlet weak var mapView: MKMapView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    var viewModel: UserInfoCellVM? {
        didSet {
            titleLabel.text = viewModel?.getAddressCellTitle()
            addressLabel.text = viewModel?.getCompleteAddress()
            self.setupMapAnnotation()
        }
    }
    
    private func setupMapAnnotation() {
        let annotation = MKPointAnnotation()
        annotation.title = viewModel?.getCompleteAddress()
        if let coordinates = viewModel?.getUserCoordinate() {
            annotation.coordinate = coordinates
            
            self.mapView.addAnnotation(annotation)
            self.mapView.setCenter(coordinates, animated: true)
        }
        
    }

}

