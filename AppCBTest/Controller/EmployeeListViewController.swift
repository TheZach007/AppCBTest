//
//  EmployeeListViewController.swift
//  AppCBTest
//
//  Created by Kevin Fachal on 20/11/20.
//

import UIKit
import Alamofire
import SwiftyJSON

class EmployeeListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var statusLabel: UILabel!
    
    var employeeArray = [Any]()
    var showAllDataEmployees : [showData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.isHidden = true
        employeeArray.removeAll()
        showAllDataEmployees.removeAll()
        getData()
    }
    
    @IBAction func refreshAction(_ sender: Any) {
        tableView.isHidden = true
        employeeArray.removeAll()
        showAllDataEmployees.removeAll()
        getData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showAllDataEmployees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let employeeCell : EmployeeTableViewCell = tableView.dequeueReusableCell(withIdentifier: "employeeCell", for: indexPath) as! EmployeeTableViewCell
        
        employeeCell.idLabel.text =  "ID : \(showAllDataEmployees[indexPath.row].idValue)"
        employeeCell.nameLabel.text = "Name : \(showAllDataEmployees[indexPath.row].nameValue)"
        employeeCell.salaryLabel.text = "Salary : $ \(showAllDataEmployees[indexPath.row].salaryValue).00"
        employeeCell.ageLabel.text = "Age : \(showAllDataEmployees[indexPath.row].ageValue) Years Old"
        
        return employeeCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        UserDefaults.standard.set(showAllDataEmployees[indexPath.row].idValue, forKey: "idValue")
        UserDefaults.standard.set(showAllDataEmployees[indexPath.row].nameValue, forKey: "nameValue")
        UserDefaults.standard.set(showAllDataEmployees[indexPath.row].salaryValue, forKey: "salaryValue")
        UserDefaults.standard.set(showAllDataEmployees[indexPath.row].ageValue, forKey: "ageValue")
        
        performSegue(withIdentifier: "toDetails", sender: self)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            AF.request("http://dummy.restapiexample.com/api/v1/delete/" + "\(showAllDataEmployees[indexPath.row].idValue)", method: .delete ,encoding: JSONEncoding.default).responseJSON {
            response in switch response.result {
            case .success(let data):
                print(data)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            case .failure(let error):
                print(error)
            }
            }
        }
    }
    
    func getData() {
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        view.addSubview(activityIndicator)
        activityIndicator.center = CGPoint(x: view.frame.size.width*0.5, y: view.frame.size.height*0.5)
        activityIndicator.startAnimating()
        
        showAllDataEmployees = []
        AF.request("http://dummy.restapiexample.com/api/v1/employees", method: .get ,encoding: JSONEncoding.default).responseJSON {
        response in switch response.result {
        case .success(let data):
            print(data)
            
            if let data = response.data {
            guard let json = try? JSON(data: data) else { return }
            self.employeeArray = json.arrayValue
            print(json)
            for (_, subJson) in json["data"] {
                
                let idData = subJson["id"].int ?? 0
            
                let nameData = subJson["employee_name"].string ?? ""
                let salaryData = subJson["employee_salary"].int ?? 0
                let ageData = subJson["employee_age"].int ?? 0
                
                self.showAllDataEmployees.append(showData(idValue: idData, nameValue: nameData, salaryValue: salaryData, ageValue: ageData))
                }
            }
            self.tableView.reloadData()
            self.tableView.isHidden = false
            
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        case .failure(let error):
            print(error)
            
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
            self.tableView.isHidden = true
            }
        }
    }

    @IBAction func unwindToList(segue: UIStoryboardSegue) {
    }
}
