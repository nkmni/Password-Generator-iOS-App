//
//  SettingsModel.swift
//  Password Generator
//
//  Created by Neil Khemani on 12/7/21.
//

import Foundation

struct SettingsModel {

    var letters = Array(K.CharSets.lower)

    var passwordType: Int {
        get {
            let userDefaults = UserDefaults.standard
            return userDefaults.integer(forKey: K.UserDefaultsKeys.passwordType)
        }
        set(newPasswordType) {
            let userDefaults = UserDefaults.standard
            userDefaults.set(newPasswordType, forKey: K.UserDefaultsKeys.passwordType)
        }
    }

    var charsLength: Int {
        get {
            let userDefaults = UserDefaults.standard
            return userDefaults.integer(forKey: K.UserDefaultsKeys.charsLength)
        }
        set(newCharsLength) {
            let userDefaults = UserDefaults.standard
            userDefaults.set(newCharsLength, forKey: K.UserDefaultsKeys.charsLength)
        }
    }

    var charsLower: Bool {
        get {
            let userDefaults = UserDefaults.standard
            return userDefaults.bool(forKey: K.UserDefaultsKeys.charsLower)
        }
        set(newCharsLower) {
            let userDefaults = UserDefaults.standard
            userDefaults.set(newCharsLower, forKey: K.UserDefaultsKeys.charsLower)
        }
    }

    var charsUpper: Bool {
        get {
            let userDefaults = UserDefaults.standard
            return userDefaults.bool(forKey: K.UserDefaultsKeys.charsUpper)
        }
        set(newCharsUpper) {
            let userDefaults = UserDefaults.standard
            userDefaults.set(newCharsUpper, forKey: K.UserDefaultsKeys.charsUpper)
        }
    }

    var charsNumbers: Bool {
        get {
            let userDefaults = UserDefaults.standard
            return userDefaults.bool(forKey: K.UserDefaultsKeys.charsNumbers)
        }
        set(newCharsNumbers) {
            let userDefaults = UserDefaults.standard
            userDefaults.set(newCharsNumbers, forKey: K.UserDefaultsKeys.charsNumbers)
        }
    }

    var charsSymbols: Bool {
        get {
            let userDefaults = UserDefaults.standard
            return userDefaults.bool(forKey: K.UserDefaultsKeys.charsSymbols)
        }
        set(newCharsSymbols) {
            let userDefaults = UserDefaults.standard
            userDefaults.set(newCharsSymbols, forKey: K.UserDefaultsKeys.charsSymbols)
        }
    }

    var passphraseNumWords: Int {
        get {
            let userDefaults = UserDefaults.standard
            return userDefaults.integer(forKey: K.UserDefaultsKeys.passphraseNumWords)
        }
        set(newPassphraseNumWords) {
            let userDefaults = UserDefaults.standard
            userDefaults.set(newPassphraseNumWords, forKey: K.UserDefaultsKeys.passphraseNumWords)
        }
    }

    var passphraseDelimiter: String {
        get {
            let userDefaults = UserDefaults.standard
            return userDefaults.string(forKey: K.UserDefaultsKeys.passphraseDelimiter) ?? " "
        }
        set(newPassphraseDelimiter) {
            let userDefaults = UserDefaults.standard
            userDefaults.set(newPassphraseDelimiter, forKey: K.UserDefaultsKeys.passphraseDelimiter)
        }
    }

    var passphraseObfuscate: Bool {
        get {
            let userDefaults = UserDefaults.standard
            return userDefaults.bool(forKey: K.UserDefaultsKeys.passphraseObfuscate)
        }
        set(newPassphraseObfuscate) {
            let userDefaults = UserDefaults.standard
            userDefaults.set(newPassphraseObfuscate, forKey: K.UserDefaultsKeys.passphraseObfuscate)
        }
    }

    var passphraseObfuscationRules: [String: String] {
        get {
            let userDefaults = UserDefaults.standard
            var obfuscationRules: [String: String] = [:]
            if let data = userDefaults.data(forKey: K.UserDefaultsKeys.passphraseObfuscationRules) {
                do {
                    let decoder = JSONDecoder()
                    obfuscationRules = try decoder.decode([String: String].self, from: data)
                } catch {
                    print("Could not decode obfuscation rules from UserDefaults (error: \(error)).")
                }
            }
            return obfuscationRules
        }
        set(newObfuscationRules) {
            let userDefaults = UserDefaults.standard
            do {
                let encoder = JSONEncoder()
                let newObfuscationRulesData = try encoder.encode(newObfuscationRules)
                userDefaults.set(newObfuscationRulesData, forKey: K.UserDefaultsKeys.passphraseObfuscationRules)
            } catch {
                print("Could not encode obfuscation rules (error: \(error))")
            }
        }
    }

    func noCharsSelected() -> Bool {
        return !charsLower && !charsUpper && !charsNumbers && !charsSymbols
    }
}
