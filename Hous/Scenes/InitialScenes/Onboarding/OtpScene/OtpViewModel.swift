


import Foundation

class OtpViewModel {
    
    var mobileNumber: String?
    var enteredOTP: String = ""
    var builder = UserBuilder()
    
    var isNextButtonEnabled: Bool {
        return enteredOTP.count == 4
    }
}
