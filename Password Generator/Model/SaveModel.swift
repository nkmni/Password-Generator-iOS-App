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
        var savedPasswords: [PasswordInfo] = []
        let passwordInfo = PasswordInfo(password: self.password!, account: self.account!, username: self.username!)
        let userDefaults = UserDefaults.standard
        if let data = userDefaults.data(forKey: "SavedPasswords") {
            do {
                let decoder = JSONDecoder()
                savedPasswords = try decoder.decode([PasswordInfo].self, from: data)
            } catch {
                print("Could not decode saved passwords from UserDefaults (error: \(error)).")
                return false
            }
        }
        savedPasswords.append(passwordInfo)
        do {
            let encoder = JSONEncoder()
            let savedPasswordsData = try encoder.encode(savedPasswords)
            userDefaults.set(savedPasswordsData, forKey: "SavedPasswords")
        } catch {
            print("Could not encode saved passwords (error: \(error))")
            return false
        }
        return true
    }
    
}
