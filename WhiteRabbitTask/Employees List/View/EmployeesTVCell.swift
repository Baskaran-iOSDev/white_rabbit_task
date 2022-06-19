//
//  EmployeesTVCell.swift
//  WhiteRabbitTask
//
//  Created by User on 19/06/22.
//

import UIKit

class EmployeesTVCell: UITableViewCell {

    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var employeeImg: UIImageView!
    @IBOutlet weak var employeeName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
