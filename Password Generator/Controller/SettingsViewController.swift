//
//  SettingsViewController.swift
//  Password Generator
//
//  Created by Neil Khemani on 12/6/21.
//

import UIKit

class SettingsViewController: UIViewController {

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

    let defaultPasswordType = DefaultGeneratorSettings.passwordType
    let defaultCharsLength = DefaultGeneratorSettings.charsLength
    let defaultCharsLower = DefaultGeneratorSettings.charsLower
    let defaultCharsUpper = DefaultGeneratorSettings.charsUpper
    let defaultCharsNumbers = DefaultGeneratorSettings.charsNumbers
    let defaultCharsSymbols = DefaultGeneratorSettings.charsSymbols
    let defaultPassphraseNumWords = DefaultGeneratorSettings.passphraseNumWords
    let defaultPassphraseDelimiter = DefaultGeneratorSettings.passphraseDelimiter
    let defaultPassphraseObfuscate = DefaultGeneratorSettings.passphraseObfuscate

    var settingsModel = SettingsModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        charsLengthTextField.delegate = self
        passphraseNumWordsTextField.delegate = self
        passphraseDelimiterTextField.delegate = self

        let dismissKeyboardOnTap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        dismissKeyboardOnTap.cancelsTouchesInView = false
        view.addGestureRecognizer(dismissKeyboardOnTap)

        let passwordTypeSwitchFont = UIFont.systemFont(ofSize: 18)
        passwordTypeSwitch.setTitleTextAttributes([NSAttributedString.Key.font: passwordTypeSwitchFont], for: .normal)

        passwordTypeSwitch.selectedSegmentIndex = settingsModel.passwordType
        charsLengthTextField.text = String(settingsModel.charsLength)
        charsLowerSwitch.isOn = settingsModel.charsLower
        charsUpperSwitch.isOn = settingsModel.charsUpper
        charsNumbersSwitch.isOn = settingsModel.charsNumbers
        charsSymbolsSwitch.isOn = settingsModel.charsSymbols
        passphraseNumWordsTextField.text = String(settingsModel.passphraseNumWords)
        passphraseDelimiterTextField.text = settingsModel.passphraseDelimiter
        passphraseObfuscateSwitch.isOn = settingsModel.passphraseObfuscate

        toggleHiddenSettings(selectedSegmentIndex: settingsModel.passwordType)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    func hideCharactersSettings(isHidden: Bool, alpha: CGFloat) {
        UIView.animate(
            withDuration: 0,
            delay: 0,
            options: [.curveEaseOut],
            animations: {
                self.charactersSettingsStackView.isHidden = isHidden
                self.charactersSettingsStackView.alpha = alpha
            })
    }

    func hidePassphraseSettings(isHidden: Bool, alpha: CGFloat) {
        UIView.animate(
            withDuration: 0,
            delay: 0,
            options: [.curveEaseOut],
            animations: {
                self.passphraseSettingsStackView.isHidden = isHidden
                self.passphraseSettingsStackView.alpha = alpha
            })
    }

    func toggleHiddenSettings(selectedSegmentIndex: Int) {
        if selectedSegmentIndex == 0 {
            hideCharactersSettings(isHidden: false, alpha: 1.0)
            hidePassphraseSettings(isHidden: true, alpha: 0.0)
        } else {
            hideCharactersSettings(isHidden: true, alpha: 0.0)
            hidePassphraseSettings(isHidden: false, alpha: 1.0)
        }
    }

    @IBAction func passwordTypeToggled(_ sender: UISegmentedControl) {
        settingsModel.passwordType = sender.selectedSegmentIndex
        toggleHiddenSettings(selectedSegmentIndex: sender.selectedSegmentIndex)
    }

    @IBAction func charsLengthEdited(_ sender: UITextField) {
        if sender.text != "" {
            settingsModel.charsLength = Int(sender.text!)!
        } else {
            settingsModel.charsLength = defaultCharsLength
            charsLengthTextField.text = String(defaultCharsLength)
        }
    }

    @IBAction func charsLowerToggled(_ sender: UISwitch) {
        settingsModel.charsLower = sender.isOn
    }

    @IBAction func charsUpperToggled(_ sender: UISwitch) {
        settingsModel.charsUpper = sender.isOn
    }

    @IBAction func charsNumbersToggled(_ sender: UISwitch) {
        settingsModel.charsNumbers = sender.isOn
    }

    @IBAction func charsSymbolsToggled(_ sender: UISwitch) {
        settingsModel.charsSymbols = sender.isOn
    }

    @IBAction func passphraseNumWordsEdited(_ sender: UITextField) {
        if sender.text != "" {
            settingsModel.passphraseNumWords = Int(sender.text!)!
        } else {
            settingsModel.passphraseNumWords = defaultPassphraseNumWords
            passphraseNumWordsTextField.text = String(defaultPassphraseNumWords)
        }
    }

    @IBAction func passphraseDelimiterEdited(_ sender: UITextField) {
        if sender.text != "" {
            settingsModel.passphraseDelimiter = sender.text!
        } else {
            settingsModel.passphraseDelimiter = defaultPassphraseDelimiter
            passphraseDelimiterTextField.text = defaultPassphraseDelimiter
        }
    }

    @IBAction func passphraseObfuscateToggled(_ sender: UISwitch) {
        settingsModel.passphraseObfuscate = sender.isOn
    }

    @IBAction func defaultButtonPressed(_ sender: UIButton) {
        settingsModel.passwordType = defaultPasswordType
        settingsModel.charsLength = defaultCharsLength
        settingsModel.charsLower = defaultCharsLower
        settingsModel.charsUpper = defaultCharsUpper
        settingsModel.charsNumbers = defaultCharsNumbers
        settingsModel.charsSymbols = defaultCharsSymbols
        settingsModel.passphraseNumWords = defaultPassphraseNumWords
        settingsModel.passphraseDelimiter = defaultPassphraseDelimiter
        settingsModel.passphraseObfuscate = defaultPassphraseObfuscate

        passwordTypeSwitch.selectedSegmentIndex = defaultPasswordType
        charsLengthTextField.text = String(defaultCharsLength)
        charsLowerSwitch.isOn = defaultCharsLower
        charsUpperSwitch.isOn = defaultCharsUpper
        charsNumbersSwitch.isOn = defaultCharsNumbers
        charsSymbolsSwitch.isOn = defaultCharsSymbols
        passphraseNumWordsTextField.text = String(defaultPassphraseNumWords)
        passphraseDelimiterTextField.text = defaultPassphraseDelimiter
        passphraseObfuscateSwitch.isOn = defaultPassphraseObfuscate

        toggleHiddenSettings(selectedSegmentIndex: passwordTypeSwitch.selectedSegmentIndex)
    }

    @IBAction func doneButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension SettingsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}
