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

    ///TEXTFIELD
    @IBAction func nameType(_ sender: Any) {
        nameField.layer.borderColor = UIColor.clear.cgColor
    }
    @IBAction func salaryType(_ sender: Any) {
        salaryField.layer.borderColor = UIColor.clear.cgColor
    }
    @IBAction func ageType(_ sender: Any) {
        ageField.layer.borderColor = UIColor.clear.cgColor
    }
    
    ///BUTTON
    @IBAction func submitAction(_ sender: Any) {
        checkField()
    }
    
    @IBAction func showAllAction(_ sender: Any) {
        performSegue(withIdentifier: "toShowAll", sender: self)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view?.endEditing(true)
        return false
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view?.endEditing(true)
    }
    
    func checkField() {
        if (nameField.text?.isEmpty == true) {
            nameField.layer.borderColor = UIColor.red.cgColor
            nameField.layer.borderWidth = 1
        }
        if (salaryField.text?.isEmpty == true) {
            salaryField.layer.borderColor = UIColor.red.cgColor
            salaryField.layer.borderWidth = 1
        }
        if (ageField.text?.isEmpty == true) {
            ageField.layer.borderColor = UIColor.red.cgColor
            ageField.layer.borderWidth = 1
        }
        if (nameField.text?.isEmpty == false) && (salaryField.text?.isEmpty == false) && (ageField.text?.isEmpty == false) {
            print("Submitted!")
        }
    }
    
    @IBAction func unwindToInput(segue: UIStoryboardSegue) {
    }
}

