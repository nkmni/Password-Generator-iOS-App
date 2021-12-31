//
//  SaveModel.swift
//  Password Generator
//
//  Created by Neil Arcade on 12/29/21.
//

import Foundation

struct SaveModel {

    var password: String?
    var account: String?
    var username: String?

    mutating func setPassword(_ password: String) {
        self.password = password
    }

    mutating func setAccount(_ accountOptional: String?) {
        if let account = accountOptional {
            self.account = account
        }
    }

    mutating func setUsername(_ usernameOptional: String?) {
        if let username = usernameOptional {
            self.username = username
        }
    }

    func savePassword() -> Bool {
        if account == nil || username == nil || account == "" || username == "" {
            return false
        }
        let userDefaults = UserDefaults.standard
        userDefaults.set(password, forKey: "Password:" + account! + ";" + username!)
        return true
    }
    
}
