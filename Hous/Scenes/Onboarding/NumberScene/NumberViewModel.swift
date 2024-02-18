//
//  NumberViewModel.swift
//  Hous
//
//  Created by Ilahe Samedova on 31.01.24.
//

import Foundation

class NumberViewModel {
    var userBuilder: UserBuilder
    
    init(builder: UserBuilder) {
        self.userBuilder = builder
    }
    
    func updateMobileNumber(_ number: String) {
        userBuilder = userBuilder.withMobileNumber(number)
    }
}
