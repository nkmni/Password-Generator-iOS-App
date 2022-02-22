//
//  PwGenModel.swift
//  Password Generator
//
//  Created by Neil Khemani on 12/5/21.
//

import Foundation

struct GeneratorModel {

    var wordList: [String: String] = [:]
//    var obfuscationRules: [String: String] = [:]

    var settingsModel = SettingsModel()

//    var passwordType: Int?
//    var charsLength: Int?
//    var charsLower: Bool?
//    var charsUpper: Bool?
//    var charsNumbers: Bool?
//    var charsSymbols: Bool?
//    var passphraseNumWords: Int?
//    var passphraseDelimiter: String?
//    var passphraseObfuscate: Bool?

    let defaultPasswordType = K.DefaultSettings.passwordType
    let defaultCharsLength = K.DefaultSettings.charsLength
    let defaultCharsLower = K.DefaultSettings.charsLower
    let defaultCharsUpper = K.DefaultSettings.charsUpper
    let defaultCharsNumbers = K.DefaultSettings.charsNumbers
    let defaultCharsSymbols = K.DefaultSettings.charsSymbols
    let defaultPassphraseNumWords = K.DefaultSettings.passphraseNumWords
    let defaultPassphraseDelimiter = K.DefaultSettings.passphraseDelimiter
    let defaultPassphraseObfuscate = K.DefaultSettings.passphraseObfuscate
    let defaultPassphraseObfuscationRules = K.DefaultSettings.passphraseObfuscationRules

    init() {
        let userDefaults = UserDefaults.standard
        let numPwGenModelInits = userDefaults.integer(forKey: K.UserDefaultsKeys.numGeneratorModelInits)
        if numPwGenModelInits == 0 {
            userDefaults.set(defaultPasswordType, forKey: K.UserDefaultsKeys.passwordType)
            userDefaults.set(defaultCharsLength, forKey: K.UserDefaultsKeys.charsLength)
            userDefaults.set(defaultCharsLower, forKey: K.UserDefaultsKeys.charsLower)
            userDefaults.set(defaultCharsUpper, forKey: K.UserDefaultsKeys.charsUpper)
            userDefaults.set(defaultCharsNumbers, forKey: K.UserDefaultsKeys.charsNumbers)
            userDefaults.set(defaultCharsSymbols, forKey: K.UserDefaultsKeys.charsSymbols)
            userDefaults.set(defaultPassphraseNumWords, forKey: K.UserDefaultsKeys.passphraseNumWords)
            userDefaults.set(defaultPassphraseDelimiter, forKey: K.UserDefaultsKeys.passphraseDelimiter)
            userDefaults.set(defaultPassphraseObfuscate, forKey: K.UserDefaultsKeys.passphraseObfuscate)
            do {
                let encoder = JSONEncoder()
                let obfuscationRulesData = try encoder.encode(defaultPassphraseObfuscationRules)
                userDefaults.set(obfuscationRulesData, forKey: K.UserDefaultsKeys.passphraseObfuscationRules)
            } catch {
                print("Could not encode obfuscation rules (error: \(error))")
            }
        }
        userDefaults.set(1+numPwGenModelInits, forKey: K.UserDefaultsKeys.numGeneratorModelInits)

        if let path = Bundle.main.path(forResource: K.Filenames.wordList, ofType: "txt") {
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
    }

    func generateCharsPassword() -> String {
        var charSet = ""
        if settingsModel.charsLower {
            charSet += K.CharSets.lower
        }
        if settingsModel.charsUpper {
            charSet += K.CharSets.upper
        }
        if settingsModel.charsNumbers {
            charSet += K.CharSets.numbers
        }
        if settingsModel.charsSymbols {
            charSet += K.CharSets.symbols
        }
        if charSet == "" {
            return "Must include at least 1 of lowercase, uppercase, number, and symbol characters!"
        }
        return String((0..<settingsModel.charsLength).map{_ in charSet.randomElement()!})
    }

    func generatePassphrase() -> (String, String) {
        var passphrase = ""
        var unobfuscatedPassphrase = ""
        for i in 0..<settingsModel.passphraseNumWords {
            var wordID = ""
            for _ in 0..<5 {
                let diceRoll = Int.random(in: 1...6)
                wordID += String(diceRoll)
            }
            let word = wordList[wordID]!
            var obfuscatedWord = word
            if settingsModel.passphraseObfuscate == true {
                for (symbol, obfuscation) in settingsModel.passphraseObfuscationRules {
                    if obfuscation == "n/a" {
                        continue
                    }
                    obfuscatedWord = obfuscatedWord.replacingOccurrences(of: symbol, with: obfuscation)
                }
            }
            passphrase += obfuscatedWord
            unobfuscatedPassphrase += word
            if i < settingsModel.passphraseNumWords - 1 {
                passphrase += settingsModel.passphraseDelimiter
                unobfuscatedPassphrase += settingsModel.passphraseDelimiter
            }
        }
        return (passphrase, unobfuscatedPassphrase)
    }

//    mutating func updateModelSettings() {
//        let userDefaults = UserDefaults.standard
//        passwordType = userDefaults.integer(forKey: K.UserDefaultsKeys.passwordType)
//        charsLength = userDefaults.integer(forKey: K.UserDefaultsKeys.charsLength)
//        charsLower = userDefaults.bool(forKey: K.UserDefaultsKeys.charsLower)
//        charsUpper = userDefaults.bool(forKey: K.UserDefaultsKeys.charsUpper)
//        charsNumbers = userDefaults.bool(forKey: K.UserDefaultsKeys.charsNumbers)
//        charsSymbols = userDefaults.bool(forKey: K.UserDefaultsKeys.charsSymbols)
//        passphraseNumWords = userDefaults.integer(forKey: K.UserDefaultsKeys.passphraseNumWords)
//        passphraseDelimiter = userDefaults.string(forKey: K.UserDefaultsKeys.passphraseDelimiter)
//        passphraseObfuscate = userDefaults.bool(forKey: K.UserDefaultsKeys.passphraseObfuscate)
//        if let data = userDefaults.data(forKey: K.UserDefaultsKeys.passphraseObfuscationRules) {
//            do {
//                let decoder = JSONDecoder()
//                obfuscationRules = try decoder.decode([String: String].self, from: data)
//            } catch {
//                print("Could not decode obfuscation rules from UserDefaults (error: \(error)).")
//            }
//        }
//    }

    mutating func generatePassword() -> (String, String) {
        if settingsModel.passwordType == 0 {
            return (generateCharsPassword(), "")
        } else {
            return generatePassphrase()
        }
    }
    
}

