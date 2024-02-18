//
//  UserModel.swift
//  Hous
//
//  Created by Ilahe Samedova on 30.01.24.

import Foundation

struct UserRegistration {
    var name: String?
    var username: String?
    var profilePhoto: String?
    var email: String?
    var about: String?
}

struct User {
    var mobileNumber: String?
    var accountType: AccountType?
    var registration: UserRegistration?
}

enum AccountType: Int, CaseIterable {
    case personal
    case agent
}
