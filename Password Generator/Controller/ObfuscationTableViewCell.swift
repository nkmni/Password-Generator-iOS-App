//
//  ObfuscationTableViewCell.swift
//  Password Generator
//
//  Created by Neil Arcade on 2/11/22.
//

import UIKit

class ObfuscationTableViewCell: UITableViewCell {

    @IBOutlet weak var letterLabel: UILabel!
    @IBOutlet weak var replacementPickerView: UIPickerView!

    var settingsViewController: SettingsViewController?
    var settingsModel = SettingsModel()

    static var replacementPickerViewData: [String] {
        let numbersSymbols = Array(K.CharSets.numbers + K.CharSets.symbols).map { String($0) }
        return ["n/a"] + numbersSymbols
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        replacementPickerView.delegate = self
        replacementPickerView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    var indexPathRow: Int? {
        guard let superView = self.superview as? UITableView else {
            print("(indexPathRow) superview is not a UITableView.")
            return nil
        }
        let indexPath = superView.indexPath(for: self)
        return indexPath?.row
    }
    
}

extension ObfuscationTableViewCell: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ObfuscationTableViewCell.replacementPickerViewData.count
    }

//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return String(ObfuscationTableViewCell.replacementPickerViewData[row])
//    }

    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = String(ObfuscationTableViewCell.replacementPickerViewData[row])
        return NSAttributedString(string: titleData, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        settingsModel.passphraseObfuscationRules[letterLabel.text!] = ObfuscationTableViewCell.replacementPickerViewData[row]
    }
}
