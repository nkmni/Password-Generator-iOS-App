//
//  SavedViewController.swift
//  Password Generator
//
//  Created by Neil Arcade on 12/27/21.
//

import UIKit

class SaveViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var passwordDisplay: UITextView!
    @IBOutlet weak var accountTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!

    var saveModel = SaveModel()
    var password: String?
    var account: String?
    var username: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        accountTextField.delegate = self
        usernameTextField.delegate = self

        let dismissKeyboardOnTap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        dismissKeyboardOnTap.cancelsTouchesInView = false
        view.addGestureRecognizer(dismissKeyboardOnTap)

        accountTextField.attributedPlaceholder = NSAttributedString(
            string: "e.g., Facebook",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )

        saveModel.setPassword(password!)
        passwordDisplay.text = password
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }

    @IBAction func accountEdited(_ sender: UITextField) {
        saveModel.setAccount(sender.text)
    }

    @IBAction func usernameEdited(_ sender: UITextField) {
        saveModel.setUsername(sender.text)
    }

    @IBAction func doneButtonPressed(_ sender: UIButton) {
        if saveModel.savePassword() {
            self.dismiss(animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Missing account or username!", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
