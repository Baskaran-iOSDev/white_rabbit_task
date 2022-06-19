//
//  EmployeeDetailVC.swift
//  WhiteRabbitTask
//
//  Created by User on 19/06/22.
//

import UIKit

class EmployeeDetailVC: UIViewController {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var websiteLbl: UILabel!
    @IBOutlet weak var companyDetailsLbl: UILabel!
    @IBOutlet weak var employeeImg: UIImageView!
    
    var employeeData = EmployeeData()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLbl.text = employeeData.name
        userNameLbl.text = employeeData.username
        emailLbl.text = employeeData.email
        addressLbl.text = employeeData.address?.street
        phoneLbl.text = employeeData.phone
        websiteLbl.text = employeeData.website
        companyDetailsLbl.text = employeeData.company?.name
        employeeImg.image = getImage(imgUrlString: employeeData.profile_image ?? "")
    }
    
}
