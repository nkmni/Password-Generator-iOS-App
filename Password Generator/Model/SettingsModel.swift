//
//  SettingsModel.swift
//  Password Generator
//
//  Created by Neil Khemani on 12/7/21.
//

import Foundation

struct SettingsModel {
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
