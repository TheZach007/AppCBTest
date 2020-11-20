//
//  DetailViewController.swift
//  AppCBTest
//
//  Created by Kevin Fachal on 20/11/20.
//

import UIKit
import Alamofire
import SwiftyJSON

class DetailViewController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var salaryField: UITextField!
    @IBOutlet weak var ageField: UITextField!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var submitBtn: UIButton!
    
    let savedId = UserDefaults.standard.integer(forKey: "idValue")
    let savedName = UserDefaults.standard.string(forKey: "nameValue")
    let savedSalary = UserDefaults.standard.integer(forKey: "salaryValue")
    let savedAge = UserDefaults.standard.integer(forKey: "ageValue")

    override func viewDidLoad() {
        super.viewDidLoad()

        statusLabel.isHidden = true
        
        nameField.text = savedName
        salaryField.text = "\(savedSalary)"
        ageField.text = "\(savedAge)"
        submitBtn.layer.cornerRadius = 10
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view?.endEditing(true)
        return false
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view?.endEditing(true)
    }
    
    func updateData() {
        let parameters =
            [
                "name" : nameField.text!,
                "salary" : salaryField.text!,
                "age" : ageField.text!
            ]
        
        AF.request("http://dummy.restapiexample.com/api/v1/update/" + "\(savedId)", method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON {
        response in switch response.result {
        case .success(let data):
            print(data)
            
            self.performSegue(withIdentifier: "unwindToList", sender: self)
            
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
            updateData()
        }
    }

}
