//
//  SavedViewController.swift
//  Password Generator
//
//  Created by Neil Arcade on 12/27/21.
//

import UIKit

class SavedViewController: UIViewController {

    @IBOutlet weak var savedTableView: UITableView!

    var savedPasswords: [PasswordInfo] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        let userDefaults = UserDefaults.standard
        if let data = userDefaults.data(forKey: K.UserDefaultsKeys.savedPasswords) {
            do {
                let decoder = JSONDecoder()
                savedPasswords = try decoder.decode([PasswordInfo].self, from: data)
            } catch {
                print("Could not decode saved passwords from UserDefaults (error: \(error)).")
            }
        }

        let nib = UINib(nibName: K.Nibs.savedCell, bundle: nil)
        savedTableView.register(nib, forCellReuseIdentifier: K.Nibs.savedCell)
        savedTableView.delegate = self
        savedTableView.dataSource = self

        let dismissKeyboardOnTap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        dismissKeyboardOnTap.cancelsTouchesInView = false
        view.addGestureRecognizer(dismissKeyboardOnTap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    @IBAction func doneButtonPressed(_ sender: UIButton) {
        let userDefaults = UserDefaults.standard
        do {
            let encoder = JSONEncoder()
            let savedPasswordsData = try encoder.encode(savedPasswords)
            userDefaults.set(savedPasswordsData, forKey: K.UserDefaultsKeys.savedPasswords)
        } catch {
            print("Could not encode saved passwords (error: \(error))")
        }
        self.dismiss(animated: true, completion: nil)
    }
}


extension SavedViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}


extension SavedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print("SavedViewController: reached tableView numberOfRowsInSection")
        return savedPasswords.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //print("SavedViewController: reached tableView cellForRowAt")
        let cell = tableView.dequeueReusableCell(withIdentifier: K.Nibs.savedCell, for: indexPath) as! SavedTableViewCell
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
            tableView.beginUpdates()
            savedPasswords.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
}


