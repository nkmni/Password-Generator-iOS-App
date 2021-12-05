//
//  ViewController.swift
//  Password Generator
//
//  Created by Neil Khemani on 12/3/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var passwordDisplay: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func generateButtonPressed(_ sender: UIButton) {
        passwordDisplay.text = ""
        for i in 0..<6 {
            var roll = ""
            for _ in 0..<5 {
                roll += "\(Int.random(in: 1...6))"
            }
            passwordDisplay.text += roll
            if i < 5 {
                passwordDisplay.text += "-"
            }
        }
    }

    @IBAction func copyButtonPressed(_ sender: UIButton) {
        UIPasteboard.general.string = passwordDisplay.text
    }
}

