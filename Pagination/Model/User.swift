//
//  User.swift
//  Pagination
//
//  Created by Softsuave-iOS dev on 12/02/25.
//
struct User: Codable, Identifiable {
    var id: Int
    let name: String
    let username: String
    let email: String
    let address: Address
    
}

struct Geo: Codable {
    let lat: String
    let lng: String
}


struct Address: Codable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: Geo
}
