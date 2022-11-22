//
//  ViewController.swift
//  M6
//
//  Created by George Smith
//

import UIKit

class ViewController2: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var sliderTextEntry: UITextField!
    @IBOutlet weak var sliderTextValue: UILabel!
    var sliderValue = "55"
    var sourceVC : UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        sliderTextEntry.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        sliderTextEntry?.text = sliderValue
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        let src = sourceVC as! ViewController1
        if (Float(sliderTextEntry.text!)! <= 100 && Float(sliderTextEntry.text!)! >= 0) {
            src.sliderValueText.text = sliderTextEntry.text
            src.sliderNum.value = Float(sliderValue)!
            src.errorMessage.text = ""
        }
        else {
            src.errorMessage.text = "Invalid Slider Value Entered"
        }
    }
    @IBAction func dismissKB(_ sender: Any) {
        sliderTextEntry.resignFirstResponder()
    }
    
    @IBAction func sliderTextChange(_ sender: UITextField) {
        sliderValue = sliderTextEntry.text!
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let isNumber = CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: string))
        let withDecimal = (
            string == NumberFormatter().decimalSeparator &&
            textField.text?.contains(string) == false
        )
        return isNumber || withDecimal
    }
}

