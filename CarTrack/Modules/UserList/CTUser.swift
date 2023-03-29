//
//  CTUser.swift
//  CarTrack
//
//  Created by Shubham Raj on 28/03/23.
//

import Foundation

struct CTUser: Codable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: CTAddress
    let phone: String
    let website: String
    let company: CTCompany
}

struct CTAddress: Codable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: CTGeo
}

struct CTCompany: Codable {
    let name: String
    let catchPhrase: String
    let bs: String
}

struct CTGeo: Codable {
    let lat: String
    let lng: String
}
