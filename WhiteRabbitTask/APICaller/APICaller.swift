//
//  APICaller.swift
//  WhiteRabbitTask
//
//  Created by User on 19/06/22.
//

import Foundation

class APICaller {
    static let shared = APICaller()
    private init() {}
    
    func employeesAPICall(url: String, completionHandler: @escaping(_ success: Bool, _ response: [EmployeeData]?) -> Void) {
        guard let url = URL(string: url) else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { data, response, err in
            if err != nil {
                print(err?.localizedDescription)
                completionHandler(false, nil)
                return
            }
            do {
                guard (data != nil) else {return}
                let json = try JSONDecoder().decode([EmployeeData].self, from: data!)
                completionHandler(true, json)
            } catch let err{
                print(err.localizedDescription)
                completionHandler(false, nil)
                return
            }
        }
        task.resume()
    }
}
