//
//  SettingsViewController.swift
//  Password Generator
//
//  Created by Neil Khemani on 12/6/21.
//

import UIKit

class SettingsViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var numWordsLabel: UILabel!
    @IBOutlet weak var numWordsStepper: UIStepper!
    @IBOutlet weak var delimiterTextField: UITextField!
    @IBOutlet weak var obfuscateToggle: UISegmentedControl!
    var settingsModel = SettingsModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delimiterTextField.delegate = self
        numWordsLabel.text = "\(settingsModel.getNumWords())"
        numWordsStepper.value = Double(settingsModel.getNumWords())
        delimiterTextField.text = settingsModel.getDelimiter()
        obfuscateToggle.selectedSegmentIndex = settingsModel.getObfuscate()
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

    @IBAction func numWordsChanged(_ sender: UIStepper) {
        numWordsLabel.text = "\(Int(sender.value))"
        settingsModel.setNumWords(Int(sender.value))
    }

    @IBAction func delimiterEdited(_ sender: UITextField) {
        if let delimiter = sender.text {
            settingsModel.setDelimiter(delimiter)
        } else {
            settingsModel.setDelimiter(" ")
            delimiterTextField.text = " "
        }
    }

    @IBAction func obfuscateToggled(_ sender: UISegmentedControl) {
        settingsModel.setObfuscate(sender.selectedSegmentIndex)
    }

    @IBAction func defaultButtonPressed(_ sender: UIButton) {
        settingsModel.setNumWords(6)
        numWordsLabel.text = "6"
        numWordsStepper.value = 6
        settingsModel.setDelimiter(" ")
        delimiterTextField.text = " "
        settingsModel.setObfuscate(0)
        obfuscateToggle.selectedSegmentIndex = settingsModel.getObfuscate()
    }

    @IBAction func doneButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
