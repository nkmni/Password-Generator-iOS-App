//
//  SettingsModel.swift
//  Password Generator
//
//  Created by Neil Khemani on 12/7/21.
//

import Foundation

struct SettingsModel {

    var passwordType: Int {
        get {
            let userDefaults = UserDefaults.standard
            return userDefaults.integer(forKey: "PasswordType")
        }
        set(newPasswordType) {
            let userDefaults = UserDefaults.standard
            userDefaults.set(newPasswordType, forKey: "PasswordType")
        }
    }

    var charsLength: Int {
        get {
            let userDefaults = UserDefaults.standard
            return userDefaults.integer(forKey: "CharsLength")
        }
        set(newCharsLength) {
            let userDefaults = UserDefaults.standard
            userDefaults.set(newCharsLength, forKey: "CharsLength")
        }
    }

    var charsLower: Bool {
        get {
            let userDefaults = UserDefaults.standard
            return userDefaults.bool(forKey: "CharsLower")
        }
        set(newCharsLower) {
            let userDefaults = UserDefaults.standard
            userDefaults.set(newCharsLower, forKey: "CharsLower")
        }
    }

    var charsUpper: Bool {
        get {
            let userDefaults = UserDefaults.standard
            return userDefaults.bool(forKey: "CharsUpper")
        }
        set(newCharsUpper) {
            let userDefaults = UserDefaults.standard
            userDefaults.set(newCharsUpper, forKey: "CharsUpper")
        }
    }

    var charsNumbers: Bool {
        get {
            let userDefaults = UserDefaults.standard
            return userDefaults.bool(forKey: "CharsNumbers")
        }
        set(newCharsNumbers) {
            let userDefaults = UserDefaults.standard
            userDefaults.set(newCharsNumbers, forKey: "CharsNumbers")
        }
    }

    var charsSymbols: Bool {
        get {
            let userDefaults = UserDefaults.standard
            return userDefaults.bool(forKey: "CharsSymbols")
        }
        set(newCharsSymbols) {
            let userDefaults = UserDefaults.standard
            userDefaults.set(newCharsSymbols, forKey: "CharsSymbols")
        }
    }

    var passphraseNumWords: Int {
        get {
            let userDefaults = UserDefaults.standard
            return userDefaults.integer(forKey: "PassphraseNumWords")
        }
        set(newPassphraseNumWords) {
            let userDefaults = UserDefaults.standard
            userDefaults.set(newPassphraseNumWords, forKey: "PassphraseNumWords")
        }
    }

    var passphraseDelimiter: String {
        get {
            let userDefaults = UserDefaults.standard
            return userDefaults.string(forKey: "PassphraseDelimiter") ?? " "
        }
        set(newPassphraseDelimiter) {
            let userDefaults = UserDefaults.standard
            userDefaults.set(newPassphraseDelimiter, forKey: "PassphraseDelimiter")
        }
    }

    var passphraseObfuscate: Bool {
        get {
            let userDefaults = UserDefaults.standard
            return userDefaults.bool(forKey: "PassphraseObfuscate")
        }
        set(newPassphraseObfuscate) {
            let userDefaults = UserDefaults.standard
            userDefaults.set(newPassphraseObfuscate, forKey: "PassphraseObfuscate")
        }
    }
}
