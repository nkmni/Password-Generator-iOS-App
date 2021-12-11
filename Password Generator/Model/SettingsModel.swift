//
//  SettingsModel.swift
//  Password Generator
//
//  Created by Neil Khemani on 12/7/21.
//

import Foundation

struct SettingsModel {
    func getNumWords() -> Int {
        let userDefaults = UserDefaults.standard
        return userDefaults.integer(forKey: "numWords")
    }

    func getDelimiter() -> String {
        let userDefaults = UserDefaults.standard
        return userDefaults.string(forKey: "delimiter") ?? " "
    }

    func getObfuscate() -> Int {
        let userDefaults = UserDefaults.standard
        return userDefaults.integer(forKey: "obfuscate")
    }

    mutating func setNumWords(_ numWords: Int) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(numWords, forKey: "numWords")
    }

    mutating func setDelimiter(_ delimiter: String) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(delimiter, forKey: "delimiter")
    }

    mutating func setObfuscate(_ obfuscate: Int) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(obfuscate, forKey: "obfuscate")
    }
}
