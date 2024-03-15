//
//  UserModel.swift
//  Hous
//
//  Created by Ilahe Samedova on 30.01.24.

import Foundation

struct User: Codable {
    var mobileNumber: String?
    var accountType: AccountType?
    var registration: UserRegistration?
}

struct UserRegistration: Codable {
    var id: Int?
    var name: String?
    var username: String?
    var profilePhoto: String?
    var email: String?
    var about: String?
}

enum AccountType: Int, CaseIterable, Codable {
    case personal
    case agent
}
