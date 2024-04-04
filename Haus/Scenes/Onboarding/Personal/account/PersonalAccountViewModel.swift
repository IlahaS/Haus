//
//  PersonalAccountViewModel.swift
//  Hous
//
//  Created by Ilahe Samedova on 14.02.24.
//

import Foundation

class PersonalAccountViewModel {

    private(set) var name: String = ""
    private(set) var username: String = ""

    var builder: UserBuilder
    
    init(builder: UserBuilder) {
        self.builder = builder
    }
    
    var isNextButtonEnabled: Bool {
        return !name.isEmpty && !username.isEmpty
    }

    func updateName(_ name: String) {
        self.name = name
    }

    func updateUsername(_ username: String) {
        self.username = username
    }

}
