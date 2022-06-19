//
//  EmployeesListVC.swift
//  WhiteRabbitTask
//
//  Created by User on 19/06/22.
//

import UIKit

class EmployeesListVC: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tblView: UITableView!
    
    var employeesViewModel = EmployeesViewModel()
    var selectedData = EmployeeData()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initViewModel()
    }
    
    // MARK: - Configuring view model
    func initViewModel(){
        employeesViewModel.reloadTableView = {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {return}
                self.tblView.reloadData()
            }
        }
        employeesViewModel.showError = {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {return}
                DispatchQueue.main.async { self.showAlert("Ups, something went wrong.") }
            }
        }
        
        employeesViewModel.showLoading = {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {return}
                DispatchQueue.main.async {
                    self.activityIndicator.isHidden = false
                    self.activityIndicator.startAnimating()
                }
            }
        }
        
        employeesViewModel.hideLoading = {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {return}
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                }
            }
        }
        
        employeesViewModel.apiCall()
    }

}

extension EmployeesListVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employeesViewModel.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeesTVCell", for: indexPath) as? EmployeesTVCell else {return UITableViewCell()}
        let dict = employeesViewModel.getEmployeeDataForCell(indexPath: indexPath)
        cell.companyName.text = dict.company?.name
        cell.employeeName.text = dict.username
        cell.employeeImg.image = getImage(imgUrlString: dict.profile_image ?? "")
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedData = employeesViewModel.getEmployeeDataForCell(indexPath: indexPath)
        self.performSegue(withIdentifier: "employeeDetailsSegue", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "employeeDetailsSegue"{
            let targetVC = segue.destination as? EmployeeDetailVC
            targetVC?.employeeData = selectedData
        }
    }
}

extension EmployeesListVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        employeesViewModel.searchPerformed(searchText: searchBar.text!)
    }
}
