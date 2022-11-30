//
//  Created by George Smith
//
import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailText: UITextField!
    @IBOutlet weak var detailedText: UITextView!
    @IBOutlet weak var  detailDescriptionLabel: UILabel!
    var masterController: MasterViewController!
 
    func configureView() {
        
        
        // Update the user interface for the detail item.
        //if let detail = detailItem {
            if let label = detailDescriptionLabel {
                label.text = masterController.objects[masterController.selectedObject]
            }
        detailText.text = masterController.objects[masterController.selectedObject]
        //detailedText.text = masterController.objects[masterController.selectedObject]
        //}
    }
    


    override func viewWillAppear(_ animated: Bool) {
      configureView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        masterController.objects[masterController.selectedObject] = detailText!.text ?? ""
    } 

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureView()
        
        //source code from Dr. Chapman's announcements
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel , target: self, action: #selector(cancelButton(_:)))
                navigationItem.rightBarButtonItem = cancelButton
        
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save , target: self, action: #selector(saveButton(_:)))
                navigationItem.leftBarButtonItem = saveButton
    }
    
    @objc
        func cancelButton(_ sender: Any) {
            //cancel = true
            performSegue(withIdentifier:"unWindSegue", sender: self )
        }
    @objc
        func saveButton(_ sender: Any) {
            //cancel = true
            performSegue(withIdentifier:"unWindSegue", sender: self )
        }

    var detailItem: NSDate? {
        didSet {
            // Update the view.
            configureView()
        }
    }


}

