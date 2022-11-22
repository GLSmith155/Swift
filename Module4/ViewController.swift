//
//  ViewController.swift
//  gls0032-Module2
//
//  Created by user225812 on 10/21/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var loanAmountField: UITextField!
    @IBOutlet weak var numPaymentsField: UITextField!
    @IBOutlet weak var interestRateField: UITextField!
    @IBOutlet weak var outputField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loanAmountField.delegate = self
        numPaymentsField.delegate = self
        interestRateField.delegate = self
    }

    @IBAction func calculate(_ sender: Any) {
        let v = Float(loanAmountField.text!) ?? 0
        let n = Int(numPaymentsField.text!) ?? 0
        let interestRate = Float(interestRateField.text!) ?? 0
        
        let i = (interestRate / 100.0)

        // n = numPayments, i = interestRate, v = loanAmount
        var denominator: Float = 0.0
        
        // calculate payment
        
        for j in 1...n {
            denominator = (denominator + (1.0 / pow((1.0 + i), Float(j))))
        }
        
        let payment =  v / denominator
        let output = String(format: "Payment = $%.2f", payment)
        
        outputField.text = output
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        loanAmountField.resignFirstResponder()
        numPaymentsField.resignFirstResponder()
        interestRateField.resignFirstResponder()
    }
    
}

extension ViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
