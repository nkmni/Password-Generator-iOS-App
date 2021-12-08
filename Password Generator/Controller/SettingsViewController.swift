//
//  SettingsViewController.swift
//  Password Generator
//
//  Created by Neil Khemani on 12/6/21.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var numWordsLabel: UILabel!
    @IBOutlet weak var numWordsStepper: UIStepper!
    @IBOutlet weak var delimiterTextField: UITextField!
    @IBOutlet weak var obfuscateToggle: UISegmentedControl!
    var settingsModel = SettingsModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        numWordsLabel.text = "\(settingsModel.numWords!)"
        numWordsStepper.value = Double(settingsModel.numWords!)
        delimiterTextField.text = settingsModel.delimiter!
        obfuscateToggle.selectedSegmentIndex = settingsModel.obfuscate!
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

    @IBAction func delimiterChanged(_ sender: UITextField) {
        if sender.text != nil {
            settingsModel.setDelimiter(sender.text!)
        } else {
            settingsModel.setDelimiter(" ")
            delimiterTextField.text = " "
        }
    }

    @IBAction func obfuscateToggled(_ sender: UISegmentedControl) {
        settingsModel.setObfuscate(sender.selectedSegmentIndex)
    }

    @IBAction func doneButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
