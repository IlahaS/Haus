//
//  UserBuilder.swift
//  Hous
//
//  Created by Ilahe Samedova on 30.01.24.
//

import UIKit

class UserBuilder {
    
    private var user: User?
    
    init() {
        user = User()
        user?.registration = UserRegistration()
    }
    
    func withName(_ name: String) -> UserBuilder {
        user?.registration?.name = name
        return self
    }
    
    func withUsername(_ username: String) -> UserBuilder {
        user?.registration?.username = username
        return self
    }
    
    func withProfilePhoto(_ profilePhoto: String) -> UserBuilder {
        user?.registration?.profilePhoto = profilePhoto
        return self
    }
    
    func withEmail(_ email: String) -> UserBuilder {
        user?.registration?.email = email
        return self
    }
    
    func withAbout(_ about: String) -> UserBuilder {
        user?.registration?.about = about
        return self
    }
    
    func withMobileNumber(_ mobileNumber: String) -> UserBuilder {
        user?.mobileNumber = mobileNumber
        return self
    }
    
    func withAccountType(_ accountType: AccountType) -> UserBuilder {
        user?.accountType = accountType
        return self
    }
    
    func build() -> User? {
        return user
    }
}
