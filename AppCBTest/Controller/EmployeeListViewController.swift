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
    
    var employeeArray = [Any]()
    var showAllDataEmployees : [showData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        
        performSegue(withIdentifier: "toDetails", sender: self)
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
            
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        case .failure(let error):
            print(error)
            }
        }
    }

    @IBAction func unwindToList(segue: UIStoryboardSegue) {
    }
}
