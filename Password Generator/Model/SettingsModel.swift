//
//  SettingsModel.swift
//  Password Generator
//
//  Created by Neil Khemani on 12/7/21.
//

import Foundation

struct SettingsModel {
    // ----GETTERS---- //

    func getPasswordType() -> Int {
        let userDefaults = UserDefaults.standard
        return userDefaults.integer(forKey: "PasswordType")
    }

    func getCharsLength() -> Int {
        let userDefaults = UserDefaults.standard
        return userDefaults.integer(forKey: "CharsLength")
    }

    func getCharsLowercase() -> Bool {
        let userDefaults = UserDefaults.standard
        return userDefaults.bool(forKey: "CharsLower")
    }

    func getCharsUppercase() -> Bool {
        let userDefaults = UserDefaults.standard
        return userDefaults.bool(forKey: "CharsUpper")
    }

    func getCharsNumbers() -> Bool {
        let userDefaults = UserDefaults.standard
        return userDefaults.bool(forKey: "CharsNumbers")
    }

    func getCharsSymbols() -> Bool {
        let userDefaults = UserDefaults.standard
        return userDefaults.bool(forKey: "CharsSymbols")
    }

    func getPassphraseNumWords() -> Int {
        let userDefaults = UserDefaults.standard
        return userDefaults.integer(forKey: "PassphraseNumWords")
    }

    func getPassphraseDelimiter() -> String {
        let userDefaults = UserDefaults.standard
        return userDefaults.string(forKey: "PassphraseDelimiter") ?? " "
    }

    func getPassphraseObfuscate() -> Bool {
        let userDefaults = UserDefaults.standard
        return userDefaults.bool(forKey: "PassphraseObfuscate")
    }

    // ----SETTERS---- //

    func setPasswordType(_ passwordType: Int) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(passwordType, forKey: "PasswordType")
    }

    func setCharsLength(_ length: Int) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(length, forKey: "CharsLength")
    }

    func setCharsLowercase(_ lowercase: Bool) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(lowercase, forKey: "CharsLower")
    }

    func setCharsUppercase(_ uppercase: Bool) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(uppercase, forKey: "CharsUpper")
    }

    func setCharsNumbers(_ numbers: Bool) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(numbers, forKey: "CharsNumbers")
    }

    func setCharsSymbols(_ symbols: Bool) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(symbols, forKey: "CharsSymbols")
    }

    func setPassphraseNumWords(_ numWords: Int) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(numWords, forKey: "PassphraseNumWords")
    }

    func setPassphraseDelimiter(_ delimiter: String) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(delimiter, forKey: "PassphraseDelimiter")
    }

    func setPassphraseObfuscate(_ obfuscate: Bool) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(obfuscate, forKey: "PassphraseObfuscate")
    }
}
