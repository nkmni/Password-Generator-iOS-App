//
//  DonateViewController.swift
//  Password Generator
//
//  Created by Neil Arcade on 12/27/21.
//

import UIKit
import StoreKit

class DonateViewController: UIViewController {

    @IBOutlet weak var donateTableView: UITableView!

    var prices = ["$0.99", "$1.99", "$3.99", "$7.99", "$15.99", "$31.99", "$59.99", "$124.99", "$249.99",
                  "$0.99/mo.", "$1.99/mo.", "$3.99/mo.", "$7.99/mo.", "$15.99/mo."]
    var productIDs = ["xyz.naiadanthem.PasswordGenerator.DonateTier1",
                      "xyz.naiadanthem.PasswordGenerator.DonateTier2",
                      "xyz.naiadanthem.PasswordGenerator.DonateTier4",
                      "xyz.naiadanthem.PasswordGenerator.DonateTier8",
                      "xyz.naiadanthem.PasswordGenerator.DonateTier16",
                      "xyz.naiadanthem.PasswordGenerator.DonateTier32",
                      "xyz.naiadanthem.PasswordGenerator.DonateTier52",
                      "xyz.naiadanthem.PasswordGenerator.DonateTier63",
                      "xyz.naiadanthem.PasswordGenerator.DonateTier77",
                      "xyz.naiadanthem.PasswordGenerator.SubscribeTier1",
                      "xyz.naiadanthem.PasswordGenerator.SubscribeTier2",
                      "xyz.naiadanthem.PasswordGenerator.SubscribeTier3",
                      "xyz.naiadanthem.PasswordGenerator.SubscribeTier4",
                      "xyz.naiadanthem.PasswordGenerator.SubscribeTier5"]

    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: K.Nibs.donateCell, bundle: nil)
        donateTableView.register(nib, forCellReuseIdentifier: K.Nibs.donateCell)
        donateTableView.delegate = self
        donateTableView.dataSource = self

        SKPaymentQueue.default().add(self)
    }

    @IBAction func doneButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    func donate(_ index: Int) {
        if SKPaymentQueue.canMakePayments() {
            let paymentRequest = SKMutablePayment()
            paymentRequest.productIdentifier = productIDs[index]
            SKPaymentQueue.default().add(paymentRequest)
        } else {
            print("Can't make payments")
        }
    }
    
}


extension DonateViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        prices.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.Nibs.donateCell, for: indexPath) as! DonateTableViewCell
        cell.priceLabel.text = prices[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        donate(indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


extension DonateViewController: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            if transaction.transactionState == .purchased {
                SKPaymentQueue.default().finishTransaction(transaction)
            } else if transaction.transactionState == .failed {
                if let error = transaction.error {
                    let errorDescription = error.localizedDescription
                    print("Transaction failed with error: \(errorDescription)")
                }
                SKPaymentQueue.default().finishTransaction(transaction)
            }
        }
    }
}
