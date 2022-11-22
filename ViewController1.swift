//
//  ViewController.swift
//  M6
//
//  Created by George Smith
//

import UIKit

class ViewController1: UIViewController {
    
    var sliderValue : Float = 0.0
    var textValue : String? = nil
    @IBOutlet weak var sliderNum: UISlider!
    @IBOutlet weak var sliderValueText: UILabel!
    @IBOutlet weak var sliderValueInit: UISlider!
    @IBOutlet weak var errorMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        sliderValueText.text = String(Int(sliderValueInit.value))
        errorMessage.text = ""
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // dispose of any resources that can be recreated
    }
    

    @IBAction func sliderBar(_ sender: UISlider) {
        sliderValue = sender.value
        sliderValueText.text = String(Int(sender.value))

    }

    
    @IBAction func sliderButton(_ sender: UIButton) {
        
    }
    @IBAction func backButton (unwindSegue: UIStoryboardSegue) {
        
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if (segue.identifier == "toModalView") {
            let destVC = segue.destination as! UINavigationController
            let destVC2 = destVC.viewControllers[0] as! ViewController2
            destVC2.sliderValue = sliderValueText.text!
            destVC2.sourceVC = self
        }
    }
    
}

