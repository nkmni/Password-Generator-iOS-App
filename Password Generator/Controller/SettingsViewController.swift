//
//  SettingsViewController.swift
//  Password Generator
//
//  Created by Neil Khemani on 12/6/21.
//

import UIKit

class SettingsViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var charactersSettingsStackView: UIStackView!
    @IBOutlet weak var passphraseSettingsStackView: UIStackView!
    @IBOutlet weak var passwordTypeSwitch: UISegmentedControl!

    @IBOutlet weak var charsLengthTextField: UITextField!
    @IBOutlet weak var charsLowerSwitch: UISwitch!
    @IBOutlet weak var charsUpperSwitch: UISwitch!
    @IBOutlet weak var charsNumbersSwitch: UISwitch!
    @IBOutlet weak var charsSymbolsSwitch: UISwitch!

    @IBOutlet weak var passphraseNumWordsTextField: UITextField!
    @IBOutlet weak var passphraseDelimiterTextField: UITextField!
    @IBOutlet weak var passphraseObfuscateSwitch: UISwitch!

    let defaultPasswordType = DefaultSettings.passwordType
    let defaultCharsLength = DefaultSettings.charsLength
    let defaultCharsLower = DefaultSettings.charsLower
    let defaultCharsUpper = DefaultSettings.charsUpper
    let defaultCharsNumbers = DefaultSettings.charsNumbers
    let defaultCharsSymbols = DefaultSettings.charsSymbols
    let defaultPassphraseNumWords = DefaultSettings.passphraseNumWords
    let defaultPassphraseDelimiter = DefaultSettings.passphraseDelimiter
    let defaultPassphraseObfuscate = DefaultSettings.passphraseObfuscate

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

        if settingsModel.getPasswordType() == 0 {
            hideCharactersSettings(isHidden: false, alpha: 1.0)
            hidePassphraseSettings(isHidden: true, alpha: 0.0)
        } else {
            hideCharactersSettings(isHidden: true, alpha: 0.0)
            hidePassphraseSettings(isHidden: false, alpha: 1.0)
        }
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }

    func hideCharactersSettings(isHidden: Bool, alpha: CGFloat) {
        UIView.animate(
            withDuration: 0.2,
            delay: 0.0,
            options: [.curveEaseOut],
            animations: {
                self.charactersSettingsStackView.isHidden = isHidden
                self.charactersSettingsStackView.alpha = alpha
            })
    }

    func hidePassphraseSettings(isHidden: Bool, alpha: CGFloat) {
        UIView.animate(
            withDuration: 0.2,
            delay: 0.0,
            options: [.curveEaseOut],
            animations: {
                self.passphraseSettingsStackView.isHidden = isHidden
                self.passphraseSettingsStackView.alpha = alpha
            })
    }

    @IBAction func passwordTypeToggled(_ sender: UISegmentedControl) {
        settingsModel.setPasswordType(sender.selectedSegmentIndex)
        if sender.selectedSegmentIndex == 0 {
            hideCharactersSettings(isHidden: false, alpha: 1.0)
            hidePassphraseSettings(isHidden: true, alpha: 0.0)
        } else {
            hideCharactersSettings(isHidden: true, alpha: 0.0)
            hidePassphraseSettings(isHidden: false, alpha: 1.0)
        }
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
