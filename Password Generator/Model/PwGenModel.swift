//
//  PwGenModel.swift
//  Password Generator
//
//  Created by Neil Khemani on 12/5/21.
//

import Foundation

struct PwGenModel {
    var numWords: Int?
    var delimiter: String?
    var obfuscate: Int?
    var wordList: [String: String] = [:]
    var obfuscationTable: [String: String] = [:]

    init() {
        let userDefaults = UserDefaults.standard
        let numPwGenModelInits = userDefaults.integer(forKey: "numPwGenModelInits")
        if numPwGenModelInits == 0 {
            userDefaults.set(6, forKey: "numWords")
            userDefaults.set(" ", forKey: "delimiter")
            userDefaults.set(0, forKey: "obfuscate")
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
    }

    mutating func updateModelSettings() {
        let userDefaults = UserDefaults.standard
        self.numWords = userDefaults.integer(forKey: "numWords")
        self.delimiter = userDefaults.string(forKey: "delimiter")
        self.obfuscate = userDefaults.integer(forKey: "obfuscate")
    }

    mutating func generatePassword() -> String {
        self.updateModelSettings()
        var password = ""
        for i in 0..<self.numWords! {
            var wordID = ""
            for _ in 0..<5 {
                let diceRoll = Int.random(in: 1...6)
                wordID += "\(diceRoll)"
            }
            password += wordList[wordID]!
            if i < self.numWords! - 1 {
                password += self.delimiter!
            }
        }
        // TODO: Obfuscate password if necessary
        return password
    }
}

