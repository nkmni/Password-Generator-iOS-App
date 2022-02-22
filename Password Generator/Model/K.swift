//
//  DefaultSettings.swift
//  Password Generator
//
//  Created by Neil Arcade on 1/30/22.
//

import Foundation

struct K {
    struct Filenames {
        static let wordList = "eff_large_wordlist"
        static let obfuscationTable = "obfuscation_table"
    }

    struct UserDefaultsKeys {
        static let numGeneratorModelInits = "numGeneratorModelInits"
        static let passwordType = "PasswordType"
        static let charsLength = "CharsLength"
        static let charsLower = "CharsLower"
        static let charsUpper = "CharsUpper"
        static let charsNumbers = "CharsNumbers"
        static let charsSymbols = "CharsSymbols"
        static let passphraseNumWords = "PassphraseNumWords"
        static let passphraseDelimiter = "PassphraseDelimiter"
        static let passphraseObfuscate = "PassphraseObfuscate"
        static let passphraseObfuscationRules = "PassphraseObfuscationRules"
        static let savedPasswords = "SavedPasswords"
    }

    struct DefaultSettings {
        static let passwordType = 1
        static let charsLength = 8
        static let charsLower = true
        static let charsUpper = true
        static let charsNumbers = true
        static let charsSymbols = true
        static let passphraseNumWords = 3
        static let passphraseDelimiter = "-"
        static let passphraseObfuscate = false
        static let passphraseObfuscationRules: [String: String] = [
            "a": "@",
            "b": "8",
            "c": "(",
            "d": ")",
            "e": "3",
            "f": "n/a",
            "g": "6",
            "h": "#",
            "i": "!",
            "j": "n/a",
            "k": "n/a",
            "l": "1",
            "m": "n/a",
            "n": "n/a",
            "o": "0",
            "p": "n/a",
            "q": "n/a",
            "r": "n/a",
            "s": "$",
            "t": "+",
            "u": "n/a",
            "v": "n/a",
            "w": "n/a",
            "x": "n/a",
            "y": "n/a",
            "z": "2"
        ]
    }

    struct CharSets {
        static let lower = "abcdefghijklmnopqrstuvwxyz"
        static let upper = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        static let numbers = "0123456789"
        static let symbols = "!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~" // include whitespace?
    }

    struct Segues {
        static let goToSettings = "goToSettings"
        static let goToSave = "goToSave"
        static let goToSaved = "goToSaved"
        static let goToDonate = "goToDonate"
    }

    struct Nibs {
        static let savedCell = "SavedTableViewCell"
        static let obfuscationCell = "ObfuscationTableViewCell"
        static let donateCell = "DonateTableViewCell"
    }
}
