//
//  PwGenModel.swift
//  Password Generator
//
//  Created by Neil Khemani on 12/5/21.
//

import Foundation

struct PwGenModel {
    var numWords = 6
    var delimiter = " "
    var obfuscate = false
    var wordList: [String: String] = [:]
    var obfuscationTable: [String: String] = [:]

    init() {
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
        // TODO: Load obfuscation table
    }

    mutating func setNumWords(numWords: Int) {
        self.numWords = numWords
    }

    mutating func setDelimiter(delimiter: String) {
        self.delimiter = delimiter
    }

    mutating func setObfuscate(obfuscate: Bool) {
        self.obfuscate = obfuscate
    }

    func generatePassword() -> String {
        var password = ""
        for i in 0..<self.numWords {
            var wordID = ""
            for _ in 0..<5 {
                let diceRoll = Int.random(in: 1...6)
                wordID += "\(diceRoll)"
            }
            password += wordList[wordID]!
            if i < self.numWords - 1 {
                password += self.delimiter
            }
        }
        // TODO: Obfuscate password if necessary
        return password
    }
}

