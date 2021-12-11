//
//  ViewController.swift
//  Password Generator
//
//  Created by Neil Khemani on 12/3/21.
//

import UIKit

class GenerateViewController: UIViewController {
    @IBOutlet weak var passwordDisplay: UITextView!
    var pwGenModel = PwGenModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func generateButtonPressed(_ sender: UIButton) {
        let password = pwGenModel.generatePassword()
        passwordDisplay.text = password
    }

    @IBAction func settingsButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToSettings", sender: self)
    }

    @IBAction func copyButtonPressed(_ sender: UIButton) {
        UIPasteboard.general.string = passwordDisplay.text

        // Display "Copied!"
        let alert = UIAlertController(title: "Copied!", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.

        /*
        if (segue.identifier == "goToSettings") {
            let settingsVC = segue.destination as! SettingsViewController
        }
         */
    }
     */
}

