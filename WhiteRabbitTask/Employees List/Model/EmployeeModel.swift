//
//  EmployeeModel.swift
//  WhiteRabbitTask
//
//  Created by User on 19/06/22.
//

import Foundation

struct EmployeeData: Codable {
    var id: Int?
    var name: String?
    var username: String?
    var email: String?
    var profile_image: String?
    var address: Address?
    var phone: String?
    var website: String?
    var company: CompanyData?
    var imgData: Data?
}

struct Address: Codable {
    var street: String?
    var suite: String?
    var city: String?
    var zipcode: String?
    var geo: Coordinates?
}

struct Coordinates: Codable{
    var lat: String?
    var lng: String?
}

struct CompanyData: Codable{
    var name: String?
    var catchPhrase: String?
    var bs: String?
}
