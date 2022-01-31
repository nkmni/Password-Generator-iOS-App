//
//  PwGenModel.swift
//  Password Generator
//
//  Created by Neil Khemani on 12/5/21.
//

import Foundation

struct PwGenModel {

    var wordList: [String: String] = [:]
    var obfuscationTable: [String: String] = [:]

    var passwordType: Int?

    var charsLength: Int?
    var charsLower: Bool?
    var charsUpper: Bool?
    var charsNumbers: Bool?
    var charsSymbols: Bool?

    var passphraseNumWords: Int?
    var passphraseDelimiter: String?
    var passphraseObfuscate: Bool?

    let defaultPasswordType = DefaultSettings.passwordType
    let defaultCharsLength = DefaultSettings.charsLength
    let defaultCharsLower = DefaultSettings.charsLower
    let defaultCharsUpper = DefaultSettings.charsUpper
    let defaultCharsNumbers = DefaultSettings.charsNumbers
    let defaultCharsSymbols = DefaultSettings.charsSymbols
    let defaultPassphraseNumWords = DefaultSettings.passphraseNumWords
    let defaultPassphraseDelimiter = DefaultSettings.passphraseDelimiter
    let defaultPassphraseObfuscate = DefaultSettings.passphraseObfuscate

    init() {
        let userDefaults = UserDefaults.standard
        let numPwGenModelInits = userDefaults.integer(forKey: "numPwGenModelInits")
        if numPwGenModelInits == 0 {
            userDefaults.set(defaultPasswordType, forKey: "PasswordType")
            userDefaults.set(defaultCharsLength, forKey: "CharsLength")
            userDefaults.set(defaultCharsLower, forKey: "CharsLower")
            userDefaults.set(defaultCharsUpper, forKey: "CharsUpper")
            userDefaults.set(defaultCharsNumbers, forKey: "CharsNumbers")
            userDefaults.set(defaultCharsSymbols, forKey: "CharsSymbols")
            userDefaults.set(defaultPassphraseNumWords, forKey: "PassphraseNumWords")
            userDefaults.set(defaultPassphraseDelimiter, forKey: "PassphraseDelimiter")
            userDefaults.set(defaultPassphraseObfuscate, forKey: "PassphraseObfuscate")
        }
        userDefaults.set(1+numPwGenModelInits, forKey: "numPwGenModelInits")
        self.updateModelSettings()

        if let path = Bundle.main.path(forResource: "eff_large_wordlist", ofType: "txt") {
            do {
                let data = try String(contentsOfFile: path, encoding: .utf8)
                let lines = data.components(separatedBy: .newlines)
                for line in lines {
                    if line == "" {
                        continue
                    }
                    let idWord = line.components(separatedBy: "\t")
                    self.wordList[idWord[0]] = idWord[1]
                }
            } catch {
                print(error)
            }
        }

        if let path = Bundle.main.path(forResource: "obfuscation_table", ofType: "txt") {
            do {
                let data = try String(contentsOfFile: path, encoding: .utf8)
                let lines = data.components(separatedBy: .newlines)
                for line in lines {
                    if line == "" {
                        continue
                    }
                    let symbolToLeet = line.components(separatedBy: " ")
                    self.obfuscationTable[symbolToLeet[0]] = symbolToLeet[1]
                }
            } catch {
                print(error)
            }
        }
    }

    func generateCharsPassword() -> String {
        let lowerChars = "abcdefghijklmnopqrstuvwxyz"
        let upperChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let numbers = "0123456789"
        let symbols = " !\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~"
        var charSet = ""
        if self.charsLower! {
            charSet += lowerChars
        }
        if self.charsUpper! {
            charSet += upperChars
        }
        if self.charsNumbers! {
            charSet += numbers
        }
        if self.charsSymbols! {
            charSet += symbols
        }
        if charSet == "" {
            return "Must include at least 1 of lowercase, uppercase, number, and symbol characters!"
        }
        return String((0..<self.charsLength!).map{_ in charSet.randomElement()!})
    }

    func generatePassphrase() -> String {
        var passphrase = ""
        for i in 0..<self.passphraseNumWords! {
            var wordID = ""
            for _ in 0..<5 {
                let diceRoll = Int.random(in: 1...6)
                wordID += String(diceRoll)
            }
            var word = wordList[wordID]!
            if passphraseObfuscate == true {
                for (symbol, obfuscation) in obfuscationTable {
                    word = word.replacingOccurrences(of: symbol, with: obfuscation)
                }
            }
            passphrase += word
            if i < self.passphraseNumWords! - 1 {
                passphrase += self.passphraseDelimiter!
            }
        }
        return passphrase
    }

    mutating func updateModelSettings() {
        let userDefaults = UserDefaults.standard
        self.passwordType = userDefaults.integer(forKey: "PasswordType")
        self.charsLength = userDefaults.integer(forKey: "CharsLength")
        self.charsLower = userDefaults.bool(forKey: "CharsLower")
        self.charsUpper = userDefaults.bool(forKey: "CharsUpper")
        self.charsNumbers = userDefaults.bool(forKey: "CharsNumbers")
        self.charsSymbols = userDefaults.bool(forKey: "CharsSymbols")
        self.passphraseNumWords = userDefaults.integer(forKey: "PassphraseNumWords")
        self.passphraseDelimiter = userDefaults.string(forKey: "PassphraseDelimiter")
        self.passphraseObfuscate = userDefaults.bool(forKey: "PassphraseObfuscate")
    }

    mutating func generatePassword() -> String {
        self.updateModelSettings()
        if self.passwordType == 0 {
            return self.generateCharsPassword()
        } else {
            return self.generatePassphrase()
        }
    }
    
}

