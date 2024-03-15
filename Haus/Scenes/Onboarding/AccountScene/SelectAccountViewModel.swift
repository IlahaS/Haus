//
//  SelectAccountViewModel.swift
//  Hous
//
//  Created by Ilahe Samedova on 01.02.24.
//

import Foundation

class SelectAccountViewModel {
    
    private(set) var selectedAccountType: [AccountType] = [.personal, .agent]
    var selectedAccountIndex: Int?
    var builder: UserBuilder
    
    init(builder: UserBuilder) {
        self.builder = builder
    }
    
    var isNextButtonEnabled: Bool {
        return selectedAccountIndex != nil
    }
    
    func toggleAccountSelection(for accountType: AccountType) {
        guard let index = selectedAccountType.firstIndex(of: accountType) else {
            return
        }
        
        selectedAccountIndex = index
    }
}
