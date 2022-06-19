//
//  ViewControllerExtensions.swift
//  WhiteRabbitTask
//
//  Created by User on 19/06/22.
//

import Foundation
import UIKit

extension UIViewController {
    // MARK: - Alert message
    func showAlert( _ message: String ) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func getImage(imgUrlString: String) -> UIImage{
        if let imgUrl = URL(string: imgUrlString){
            guard let data = try? Data(contentsOf: imgUrl) else {return UIImage(named: "placeholder")!}
            return UIImage(data: data)!
        }
        return UIImage(named: "placeholder")!
    }
}
