//
//  SavedViewController.swift
//  Password Generator
//
//  Created by Neil Arcade on 12/27/21.
//

import UIKit

class SavedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var savedTableView: UITableView!

    var savedPasswords: [PasswordInfo] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        let userDefaults = UserDefaults.standard
        if let data = userDefaults.data(forKey: "SavedPasswords") {
            do {
                let decoder = JSONDecoder()
                savedPasswords = try decoder.decode([PasswordInfo].self, from: data)
            } catch {
                print("Could not decode saved passwords from UserDefaults (error: \(error)).")
            }
        }

        let nib = UINib(nibName: "SavedTableViewCell", bundle: nil)
        savedTableView.register(nib, forCellReuseIdentifier: "SavedTableViewCell")
        savedTableView.delegate = self
        savedTableView.dataSource = self

        let dismissKeyboardOnTap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        dismissKeyboardOnTap.cancelsTouchesInView = false
        view.addGestureRecognizer(dismissKeyboardOnTap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }

    @IBAction func doneButtonPressed(_ sender: UIButton) {
        let userDefaults = UserDefaults.standard
        do {
            let encoder = JSONEncoder()
            let savedPasswordsData = try encoder.encode(savedPasswords)
            userDefaults.set(savedPasswordsData, forKey: "SavedPasswords")
        } catch {
            print("Could not encode saved passwords (error: \(error))")
        }
        self.dismiss(animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedPasswords.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SavedTableViewCell", for: indexPath) as! SavedTableViewCell
        cell.savedViewController = self
        cell.accountTextField.delegate = self
        cell.usernameTextField.delegate = self
        cell.accountTextField.text = savedPasswords[indexPath.row].account
        cell.usernameTextField.text = savedPasswords[indexPath.row].username
        cell.passwordLabel.text = savedPasswords[indexPath.row].password
        return cell
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            savedTableView.beginUpdates()
            savedPasswords.remove(at: indexPath.row)
            savedTableView.deleteRows(at: [indexPath], with: .fade)
            savedTableView.endUpdates()
        }
    }

}
