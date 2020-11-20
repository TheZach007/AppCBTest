//
//  ViewController.swift
//  AppCBTest
//
//  Created by Kevin Fachal on 20/11/20.
//

import UIKit
import Alamofire
import SwiftyJSON

class InputViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var salaryField: UITextField!
    @IBOutlet weak var ageField: UITextField!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var showAllBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        statusLabel.isHidden = true
        submitBtn.layer.cornerRadius = 10
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        nameField.text = ""
        salaryField.text = ""
        ageField.text = ""
        statusLabel.isHidden = true
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
    
    func postData() {
        let parameters =
            [
                "name" : nameField.text!,
                "salary" : salaryField.text!,
                "age" : ageField.text!
            ]
        
        AF.request("http://dummy.restapiexample.com/api/v1/create", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON {
        response in switch response.result {
        case .success(let data):
            print(data)
            
            self.nameField.text = ""
            self.salaryField.text = ""
            self.ageField.text = ""
            self.statusLabel.text = "Success!"
            self.statusLabel.isHidden = false
            
        case .failure(let error):
            print(error)
            
            self.statusLabel.text = "Failed, try again!"
            self.statusLabel.isHidden = false
        }
        }
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
            postData()
        }
    }
    
    @IBAction func unwindToInput(segue: UIStoryboardSegue) {
    }
}

