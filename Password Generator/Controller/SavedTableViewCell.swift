//
//  SavedTableViewCell.swift
//  Password Generator
//
//  Created by Neil Arcade on 1/29/22.
//

import UIKit

class SavedTableViewCell: UITableViewCell {
    @IBOutlet weak var accountTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!

    var savedViewController: SavedViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func getIndexPathRow() -> Int? {
        guard let superView = self.superview as? UITableView else {
            print("(getIndexPathRow) superview is not a UITableView.")
            return nil
        }
        let indexPath = superView.indexPath(for: self)
        return indexPath?.row
    }

    @IBAction func accountTextFieldEdited(_ sender: UITextField) {
        savedViewController?.savedPasswords[getIndexPathRow()!].account = accountTextField.text!
    }

    @IBAction func usernameTextFieldEdited(_ sender: UITextField) {
        savedViewController?.savedPasswords[getIndexPathRow()!].username = usernameTextField.text!
    }

    @IBAction func copyButtonPressed(_ sender: UIButton) {
        UIPasteboard.general.string = passwordLabel.text
        let alert = UIAlertController(title: "Copied!", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        savedViewController?.present(alert, animated: true, completion: nil)
    }

}
