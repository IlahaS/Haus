


import Foundation

class OtpViewModel {
    
    var mobileNumber: String?
    var enteredOTP: String = ""
    var builder: UserBuilder
    
    init(builder: UserBuilder) {
        self.builder = builder
    }
    
    var isNextButtonEnabled: Bool {
        return enteredOTP.count == 4
    }
}
