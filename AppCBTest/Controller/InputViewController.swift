//
//  ViewController.swift
//  AppCBTest
//
//  Created by Kevin Fachal on 20/11/20.
//

import UIKit

class InputViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var salaryField: UITextField!
    @IBOutlet weak var ageField: UITextField!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var showAllBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        submitBtn.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
    }

    @IBAction func submitAction(_ sender: Any) {
    }
    
    @IBAction func showAllAction(_ sender: Any) {
    }
    
    
}

