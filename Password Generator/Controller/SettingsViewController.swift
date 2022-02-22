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

    @IBOutlet weak var obfuscationTableView: UITableView!

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

    var settingsModel = SettingsModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        charsLengthTextField.delegate = self
        passphraseNumWordsTextField.delegate = self
        passphraseDelimiterTextField.delegate = self

        let nib = UINib(nibName: K.Nibs.obfuscationCell, bundle: nil)
        obfuscationTableView.register(nib, forCellReuseIdentifier: K.Nibs.obfuscationCell)
        obfuscationTableView.delegate = self
        obfuscationTableView.dataSource = self

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

    func alertNeedChars() {
        let alert = UIAlertController(title: "Must include at least 1 of lowercase, uppercase, number, or symbol characters!", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
        if settingsModel.noCharsSelected() {
            alertNeedChars()
            sender.isOn = true
            settingsModel.charsLower = sender.isOn
        }
    }

    @IBAction func charsUpperToggled(_ sender: UISwitch) {
        settingsModel.charsUpper = sender.isOn
        if settingsModel.noCharsSelected() {
            alertNeedChars()
            sender.isOn = true
            settingsModel.charsUpper = sender.isOn
        }
    }

    @IBAction func charsNumbersToggled(_ sender: UISwitch) {
        settingsModel.charsNumbers = sender.isOn
        if settingsModel.noCharsSelected() {
            alertNeedChars()
            sender.isOn = true
            settingsModel.charsNumbers = sender.isOn
        }
    }

    @IBAction func charsSymbolsToggled(_ sender: UISwitch) {
        settingsModel.charsSymbols = sender.isOn
        if settingsModel.noCharsSelected() {
            alertNeedChars()
            sender.isOn = true
            settingsModel.charsSymbols = sender.isOn
        }
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
        settingsModel.passphraseObfuscationRules = defaultPassphraseObfuscationRules

        passwordTypeSwitch.selectedSegmentIndex = defaultPasswordType
        charsLengthTextField.text = String(defaultCharsLength)
        charsLowerSwitch.isOn = defaultCharsLower
        charsUpperSwitch.isOn = defaultCharsUpper
        charsNumbersSwitch.isOn = defaultCharsNumbers
        charsSymbolsSwitch.isOn = defaultCharsSymbols
        passphraseNumWordsTextField.text = String(defaultPassphraseNumWords)
        passphraseDelimiterTextField.text = defaultPassphraseDelimiter
        passphraseObfuscateSwitch.isOn = defaultPassphraseObfuscate
        obfuscationTableView.reloadData()

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

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsModel.passphraseObfuscationRules.keys.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.Nibs.obfuscationCell, for: indexPath) as! ObfuscationTableViewCell
        cell.settingsViewController = self
        cell.letterLabel.text = String(settingsModel.letters[indexPath.row])
        cell.replacementPickerView.selectRow(ObfuscationTableViewCell.replacementPickerViewData.firstIndex(of: settingsModel.passphraseObfuscationRules[String(settingsModel.letters[indexPath.row])]!)!, inComponent: 0, animated: false)
        return cell
    }
}
