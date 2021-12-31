//
//  SettingsViewController.swift
//  Password Generator
//
//  Created by Neil Khemani on 12/6/21.
//

import UIKit

class SettingsViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var passwordTypeSwitch: UISegmentedControl!

    @IBOutlet weak var charsLengthTextField: UITextField!
    @IBOutlet weak var charsLowerSwitch: UISwitch!
    @IBOutlet weak var charsUpperSwitch: UISwitch!
    @IBOutlet weak var charsNumbersSwitch: UISwitch!
    @IBOutlet weak var charsSymbolsSwitch: UISwitch!

    @IBOutlet weak var passphraseNumWordsTextField: UITextField!
    @IBOutlet weak var passphraseDelimiterTextField: UITextField!
    @IBOutlet weak var passphraseObfuscateSwitch: UISwitch!

    let defaultPasswordType = 0
    let defaultCharsLength = 16
    let defaultCharsLower = true
    let defaultCharsUpper = true
    let defaultCharsNumbers = true
    let defaultCharsSymbols = true
    let defaultPassphraseNumWords = 6
    let defaultPassphraseDelimiter = " "
    let defaultPassphraseObfuscate = false

    var settingsModel = SettingsModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        charsLengthTextField.delegate = self
        passphraseNumWordsTextField.delegate = self
        passphraseDelimiterTextField.delegate = self

        let dismissKeyboardOnTap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        dismissKeyboardOnTap.cancelsTouchesInView = false
        view.addGestureRecognizer(dismissKeyboardOnTap)

        let passwordTypeSwitchFont = UIFont.systemFont(ofSize: 18)
        passwordTypeSwitch.setTitleTextAttributes([NSAttributedString.Key.font: passwordTypeSwitchFont], for: .normal)

        passwordTypeSwitch.selectedSegmentIndex = settingsModel.getPasswordType()
        charsLengthTextField.text = String(settingsModel.getCharsLength())
        charsLowerSwitch.isOn = settingsModel.getCharsLowercase()
        charsUpperSwitch.isOn = settingsModel.getCharsUppercase()
        charsNumbersSwitch.isOn = settingsModel.getCharsNumbers()
        charsSymbolsSwitch.isOn = settingsModel.getCharsSymbols()
        passphraseNumWordsTextField.text = String(settingsModel.getPassphraseNumWords())
        passphraseDelimiterTextField.text = settingsModel.getPassphraseDelimiter()
        passphraseObfuscateSwitch.isOn = settingsModel.getPassphraseObfuscate()
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }

    @IBAction func passwordTypeToggled(_ sender: UISegmentedControl) {
        settingsModel.setPasswordType(sender.selectedSegmentIndex)
    }

    @IBAction func charsLengthEdited(_ sender: UITextField) {
        if sender.text != "" {
            settingsModel.setCharsLength(Int(sender.text!)!)
        } else {
            settingsModel.setCharsLength(defaultCharsLength)
            charsLengthTextField.text = String(defaultCharsLength)
        }
    }

    @IBAction func charsLowerToggled(_ sender: UISwitch) {
        settingsModel.setCharsLowercase(sender.isOn)
    }

    @IBAction func charsUpperToggled(_ sender: UISwitch) {
        settingsModel.setCharsUppercase(sender.isOn)
    }

    @IBAction func charsNumbersToggled(_ sender: UISwitch) {
        settingsModel.setCharsNumbers(sender.isOn)
    }

    @IBAction func charsSymbolsToggled(_ sender: UISwitch) {
        settingsModel.setCharsSymbols(sender.isOn)
    }

    @IBAction func passphraseNumWordsEdited(_ sender: UITextField) {
        if sender.text != "" {
            settingsModel.setPassphraseNumWords(Int(sender.text!)!)
        } else {
            settingsModel.setPassphraseNumWords(defaultPassphraseNumWords)
            passphraseNumWordsTextField.text = String(defaultPassphraseNumWords)
        }
    }

    @IBAction func passphraseDelimiterEdited(_ sender: UITextField) {
        if sender.text != "" {
            settingsModel.setPassphraseDelimiter(sender.text!)
        } else {
            settingsModel.setPassphraseDelimiter(defaultPassphraseDelimiter)
            passphraseDelimiterTextField.text = defaultPassphraseDelimiter
        }
    }

    @IBAction func passphraseObfuscateToggled(_ sender: UISwitch) {
        settingsModel.setPassphraseObfuscate(sender.isOn)
    }

    @IBAction func defaultButtonPressed(_ sender: UIButton) {
        settingsModel.setPasswordType(defaultPasswordType)
        settingsModel.setCharsLength(defaultCharsLength)
        settingsModel.setCharsLowercase(defaultCharsLower)
        settingsModel.setCharsUppercase(defaultCharsUpper)
        settingsModel.setCharsNumbers(defaultCharsNumbers)
        settingsModel.setCharsSymbols(defaultCharsSymbols)
        settingsModel.setPassphraseNumWords(defaultPassphraseNumWords)
        settingsModel.setPassphraseDelimiter(defaultPassphraseDelimiter)
        settingsModel.setPassphraseObfuscate(defaultPassphraseObfuscate)

        passwordTypeSwitch.selectedSegmentIndex = defaultPasswordType
        charsLengthTextField.text = String(defaultCharsLength)
        charsLowerSwitch.isOn = defaultCharsLower
        charsUpperSwitch.isOn = defaultCharsUpper
        charsNumbersSwitch.isOn = defaultCharsNumbers
        charsSymbolsSwitch.isOn = defaultCharsSymbols
        passphraseNumWordsTextField.text = String(defaultPassphraseNumWords)
        passphraseDelimiterTextField.text = defaultPassphraseDelimiter
        passphraseObfuscateSwitch.isOn = defaultPassphraseObfuscate
    }

    @IBAction func doneButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
