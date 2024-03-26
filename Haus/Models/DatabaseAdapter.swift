//
//  DatabaseAdapter.swift
//  Haus
//
//  Created by Ilahe Samedova on 23.02.24.
//
import Foundation

class DatabaseAdapter {
    
    func saveUserInfo(user: User) {
        
        UserDefaults.standard.setValue(user.registration?.username, forKey: "username")
        
    }
    
    private func saveToKeychain(value: String, forKey key: String) {
        if let data = value.data(using: .utf8) {
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrAccount as String: key,
                kSecValueData as String: data
            ]
            
            SecItemDelete(query as CFDictionary)
            
            let status = SecItemAdd(query as CFDictionary, nil)
            guard status == errSecSuccess else {
                print("Error saving to Keychain: \(status)")
                return
            }
        }
    }
    
    private func getFromKeychain(forKey key: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        let status = withUnsafeMutablePointer(to: &result) {
            SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
        }
        
        guard status == errSecSuccess,
              let data = result as? Data,
              let value = String(data: data, encoding: .utf8) else {
            return nil
        }
        
        return value
    }
    
    func saveMobileNumberToKeychain(mobileNumber: String) {
        saveToKeychain(value: mobileNumber, forKey: "mobileNumberKey")
    }
    
    func getMobileNumberFromKeychain() -> String? {
        return getFromKeychain(forKey: "mobileNumberKey")
    }
}
