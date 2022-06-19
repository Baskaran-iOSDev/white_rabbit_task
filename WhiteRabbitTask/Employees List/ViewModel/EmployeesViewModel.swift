//
//  EmployeesViewModel.swift
//  WhiteRabbitTask
//
//  Created by User on 19/06/22.
//

import Foundation
import CoreData
import UIKit

class EmployeesViewModel {
    
    var reloadTableView: (()->())?
    var showError: (()->())?
    var showLoading: (()->())?
    var hideLoading: (()->())?
    
    var coreDataArray: [NSManagedObject] = []
    
    private var employeesArray: [EmployeeData] = [EmployeeData](){
        didSet {
            reloadTableView?()
        }
    }
    private var employeesNormalArray: [EmployeeData] = [EmployeeData](){
        didSet {
            reloadTableView?()
        }
    }
    private var employeesSearchArray: [EmployeeData] = [EmployeeData](){
        didSet {
            reloadTableView?()
        }
    }
    
    var numberOfCells: Int {
        employeesArray.count
    }
    
    func searchPerformed(searchText: String){
        if searchText == "" {
            employeesArray = employeesNormalArray
            reloadTableView?()
            return
        }
        let filteredArray = employeesArray.filter {($0.username!.lowercased().contains(searchText.lowercased())) || $0.email!.lowercased().contains(searchText.lowercased())}
        employeesSearchArray = filteredArray
        employeesArray = employeesSearchArray
        reloadTableView?()
    }
    
    func getEmployeeDataForCell(indexPath: IndexPath) -> EmployeeData{
        return employeesArray[indexPath.row]
    }
    
    func apiCall(){
        showLoading?()
        guard self.fetchCoreData() == false else {
            self.hideLoading?()
            return
        }
        APICaller.shared.employeesAPICall(url: "http://www.mocky.io/v2/5d565297300000680030a986") { [weak self] (success, response)  in
            guard let self = self else {return}
            self.hideLoading?()
            if success {
                self.employeesNormalArray = response!
                self.employeesArray = self.employeesNormalArray
                for i in self.employeesArray{
                    self.saveCoreData(employeeData: i)
                }
                self.reloadTableView?()
            } else {
                self.showError?()
            }
        }
    }
    
    func saveCoreData(employeeData:EmployeeData) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "EmployeeDetails", in: managedContext) else {return}
        let employeeDetail = NSManagedObject(entity: entity, insertInto: managedContext)
        
        employeeDetail.setValue(employeeData.id, forKey: "id")
        employeeDetail.setValue(employeeData.name, forKey: "name")
        employeeDetail.setValue(employeeData.username, forKey: "username")
        employeeDetail.setValue(employeeData.email, forKey: "email")
        employeeDetail.setValue(employeeData.profile_image, forKey: "profile_image")
        employeeDetail.setValue(employeeData.address?.street, forKey: "street")
        employeeDetail.setValue(employeeData.address?.suite, forKey: "suite")
        employeeDetail.setValue(employeeData.address?.city, forKey: "city")
        employeeDetail.setValue(employeeData.address?.city, forKey: "zipcode")
        employeeDetail.setValue(employeeData.address?.geo?.lat, forKey: "lat")
        employeeDetail.setValue(employeeData.address?.geo?.lng, forKey: "lng")
        employeeDetail.setValue(employeeData.phone, forKey: "phone")
        employeeDetail.setValue(employeeData.website, forKey: "website")
        employeeDetail.setValue(employeeData.company?.name, forKey: "companyname")
        employeeDetail.setValue(employeeData.company?.catchPhrase, forKey: "catchPhrase")
        employeeDetail.setValue(employeeData.company?.bs, forKey: "bs")
        
        do {
            try managedContext.save()
            
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    
    
    func fetchCoreData() -> Bool{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "EmployeeDetails")
        
        do {
            employeesArray.removeAll()
            let allData = try managedContext.fetch(fetchRequest)
            if allData.count > 0 {
            for i in allData{
                let obj = EmployeeData(id: (i.value(forKey: "id") as? Int), name: (i.value(forKey: "name") as? String), username: (i.value(forKey: "username") as? String), email: (i.value(forKey: "email") as? String), profile_image: (i.value(forKey: "profile_image") as? String),
                                       address: Address(street: (i.value(forKey: "street") as? String), suite: (i.value(forKey: "suite") as? String), city: (i.value(forKey: "city") as? String), zipcode: (i.value(forKey: "zipcode") as? String), geo: Coordinates(lat: (i.value(forKey: "lat") as? String), lng: (i.value(forKey: "lng") as? String))),
                                       phone: (i.value(forKey: "phone") as? String), website: (i.value(forKey: "website") as? String), company: CompanyData(name: (i.value(forKey: "name") as? String), catchPhrase: (i.value(forKey: "catchPhrase") as? String), bs: (i.value(forKey: "bs") as? String)))
                employeesNormalArray.append(obj)
            }
                employeesArray = employeesNormalArray
                return true
            } else {
                return false
            }
        } catch let err {
            print(err.localizedDescription)
            return false
        }
    }
    
}
