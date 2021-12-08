//
//  SettingsModel.swift
//  Password Generator
//
//  Created by Neil Khemani on 12/7/21.
//

import Foundation

struct SettingsModel {
    var numWords: Int? = nil
    var delimiter: String? = nil
    var obfuscate: Int? = nil

    init() {
        let userDefaults = UserDefaults.standard
        self.numWords = userDefaults.integer(forKey: "numWords")
        self.delimiter = userDefaults.string(forKey: "delimiter")
        self.obfuscate = userDefaults.integer(forKey: "obfuscate")
        if self.numWords == nil {
            self.setNumWords(6)
        }
        if self.delimiter == nil {
            self.setDelimiter(" ")
        }
        if self.obfuscate == nil {
            self.setObfuscate(0)
        }
    }

    mutating func setNumWords(_ numWords: Int) {
        self.numWords = numWords
        let userDefaults = UserDefaults.standard
        userDefaults.set(self.numWords, forKey: "numWords")
    }

    mutating func setDelimiter(_ delimiter: String) {
        self.delimiter = delimiter
        let userDefaults = UserDefaults.standard
        userDefaults.set(self.delimiter, forKey: "delimiter")
    }

    mutating func setObfuscate(_ obfuscate: Int) {
        self.obfuscate = obfuscate
        let userDefaults = UserDefaults.standard
        userDefaults.set(self.obfuscate, forKey: "obfuscate")
    }
}
