//
//  ViewController.swift
//  Password Generator
//
//  Created by Neil Khemani on 12/3/21.
//

import UIKit

class GeneratorViewController: UIViewController {

    @IBOutlet weak var passwordDisplay: UITextView!
    @IBOutlet weak var unobfuscatedLabel: UILabel!

    var generatorModel = GeneratorModel()
    var settingsModel = SettingsModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        toggleUnobfuscatedLabel()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        toggleUnobfuscatedLabel()
    }

    func hideUnobfuscatedLabel(isHidden: Bool, alpha: CGFloat) {
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            options: [.curveEaseOut],
            animations: {
                self.unobfuscatedLabel.isHidden = isHidden
                self.unobfuscatedLabel.alpha = alpha
            })
    }

    func toggleUnobfuscatedLabel() {
        if settingsModel.passwordType == 0 || !settingsModel.passphraseObfuscate {
            hideUnobfuscatedLabel(isHidden: true, alpha: 0.0)
        } else {
            hideUnobfuscatedLabel(isHidden: false, alpha: 1.0)
        }
    }

    @IBAction func generateButtonPressed(_ sender: UIButton) {
        unobfuscatedLabel.text = ""

        let (password, unobfuscatedPassword) = generatorModel.generatePassword()
        passwordDisplay.text = password

        if settingsModel.passphraseObfuscate {
            unobfuscatedLabel.text = unobfuscatedPassword
        }
    }

    @IBAction func settingsButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: K.Segues.goToSettings, sender: self)
    }

    @IBAction func copyButtonPressed(_ sender: UIButton) {
        UIPasteboard.general.string = passwordDisplay.text

        // Display "Copied!"
        let alert = UIAlertController(title: "Copied!", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func saveButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: K.Segues.goToSave, sender: self)
    }

    @IBAction func savedButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: K.Segues.goToSaved, sender: self)
    }

    @IBAction func donateButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: K.Segues.goToDonate, sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == K.Segues.goToSave) {
            let saveVC = segue.destination as! SaveViewController
            saveVC.password = passwordDisplay.text
        }
    }

}

