//
//  UserInfoCellVM.swift
//  CarTrack
//
//  Created by Shubham Raj on 28/03/23.
//

import Foundation
import MapKit

struct UserInfoCellVM {
    
    let activeUser: CTUser
    //Info
    var name: String
    var username: String
    var email: String
    var phone: String
    var website: String
    
    //Company
    var companyName: String
    var catchPhrase: String
    var bs: String
    
    init(user: CTUser) {
        activeUser = user
        
        name = user.name
        username = "@" + "\(user.username)"
        email = user.email
        phone = user.phone
        website = user.website
        
        companyName = user.company.name
        catchPhrase = user.company.catchPhrase
        bs = user.company.bs
        
    }
}

extension UserInfoCellVM {
    
    func getCompanyCellTitle() -> String {
        return "Company Information:"
    }
    
    func getAddressCellTitle() -> String {
        return "Address:"
    }
    
    func getCompleteAddress() -> String {
        let address = activeUser.address
        let street = address.street.isEmpty ? "" : "\(address.street), "
        let suite = address.suite.isEmpty ? "" : "\(address.suite), "
        let city = address.city.isEmpty ? "" : "\(address.city), "
        let zipcode = address.zipcode.isEmpty ? "" : "\(address.zipcode)"
        return [street, suite, city, zipcode].joined()
    }
    
    func getUserCoordinate() -> CLLocationCoordinate2D {
        let geoLocation = activeUser.address.geo
        let latitude = Double(geoLocation.lat) ?? 0
        let longitude = Double(geoLocation.lng) ?? 0
        return  CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
