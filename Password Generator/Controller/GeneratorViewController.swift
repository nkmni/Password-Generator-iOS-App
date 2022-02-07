//
//  ViewController.swift
//  Password Generator
//
//  Created by Neil Khemani on 12/3/21.
//

import UIKit

class GeneratorViewController: UIViewController {

    @IBOutlet weak var passwordDisplay: UITextView!
    
    var generatorModel = GeneratorModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func generateButtonPressed(_ sender: UIButton) {
        let password = generatorModel.generatePassword()
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

    @IBAction func saveButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToSave", sender: self)
    }

    @IBAction func savedButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToSaved", sender: self)
    }

    @IBAction func donateButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToDonate", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "goToSave") {
            let saveVC = segue.destination as! SaveViewController
            saveVC.password = passwordDisplay.text
        }
    }

}

