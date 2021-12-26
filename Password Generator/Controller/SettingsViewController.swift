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

    var settingsModel = SettingsModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.passphraseDelimiterTextField.delegate = self
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

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

    /*
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func passwordTypeToggled(_ sender: UISegmentedControl) {
        settingsModel.setPasswordType(sender.selectedSegmentIndex)
    }

    @IBAction func charsLengthEdited(_ sender: UITextField) {
        if let length = sender.text {
            settingsModel.setCharsLength(Int(length)!)
        } else {
            settingsModel.setCharsLength(24)
            charsLengthTextField.text = "24"
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
        if let numWords = sender.text {
            settingsModel.setPassphraseNumWords(Int(numWords)!)
        } else {
            settingsModel.setPassphraseNumWords(6)
            passphraseNumWordsTextField.text = "6"
        }
    }

    @IBAction func passphraseDelimiterEdited(_ sender: UITextField) {
        if let delimiter = sender.text {
            settingsModel.setPassphraseDelimiter(delimiter)
        } else {
            settingsModel.setPassphraseDelimiter(" ")
            passphraseDelimiterTextField.text = " "
        }
    }

    @IBAction func passphraseObfuscateToggled(_ sender: UISwitch) {
        settingsModel.setPassphraseObfuscate(sender.isOn)
    }

    @IBAction func defaultButtonPressed(_ sender: UIButton) {
        settingsModel.setPasswordType(0)
        settingsModel.setCharsLength(24)
        settingsModel.setCharsLowercase(true)
        settingsModel.setCharsUppercase(true)
        settingsModel.setCharsNumbers(true)
        settingsModel.setCharsSymbols(true)
        settingsModel.setPassphraseNumWords(6)
        settingsModel.setPassphraseDelimiter(" ")
        settingsModel.setPassphraseObfuscate(false)

        passwordTypeSwitch.selectedSegmentIndex = 0
        charsLengthTextField.text = "24"
        charsLowerSwitch.isOn = true
        charsUpperSwitch.isOn = true
        charsNumbersSwitch.isOn = true
        charsSymbolsSwitch.isOn = true
        passphraseNumWordsTextField.text = "6"
        passphraseDelimiterTextField.text = " "
        passphraseObfuscateSwitch.isOn = false
    }

    @IBAction func doneButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
