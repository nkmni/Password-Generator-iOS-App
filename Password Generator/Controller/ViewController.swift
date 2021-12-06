//
//  ViewController.swift
//  Password Generator
//
//  Created by Neil Khemani on 12/3/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var passwordDisplay: UITextView!
    var pwGenModel = PwGenModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        // TODO: Load dictionary mapping IDs to words
    }

    @IBAction func generateButtonPressed(_ sender: UIButton) {
        let password = pwGenModel.generatePassword()
        passwordDisplay.text = password
    }

    @IBAction func copyButtonPressed(_ sender: UIButton) {
        UIPasteboard.general.string = passwordDisplay.text
        // TODO: Display "Copied!" message
    }
}

