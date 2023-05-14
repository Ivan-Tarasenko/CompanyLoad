//
//  NetworkManager.swift
//  CompanyLoad
//
//  Created by Иван Тарасенко on 12.05.2023.
//

import Foundation
import UIKit

protocol NetworkManagerProtocol: AnyObject {
    func loadingData(page: Int, completion: @escaping ([EntityCompany]?, URLResponse?, Error?, String?) -> Void)
    
}

final class NetworkManager: NetworkManagerProtocol {
    
    let url = "http://dev.bonusmoney.pro/mobileapp/getAllCompanies"
    
    func loadingData(page: Int, completion: @escaping ([EntityCompany]?, URLResponse?, Error?, String?) -> Void) {
        
        let parameters = "{\n\t\"offset\": \(page)\n}"
        let postData = parameters.data(using: .utf8)
        
        var request = URLRequest(url: URL(string: url)!,
                                 timeoutInterval: Double.infinity)
        request.addValue("123", forHTTPHeaderField: "TOKEN")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpMethod = "POST"
        request.httpBody = postData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            // processing error
            if error != nil {
                completion(nil, nil, error, nil)
            }
            
            // processing response
            if response != nil {
                if let responseData = data,
                   let jsonResponse = try? JSONSerialization.jsonObject(with: responseData, options: []),
                   let errorDict = jsonResponse as? [String: Any],
                   let errorMessage = errorDict["message"] as? String {
                    completion(nil, response, nil, errorMessage)
                }
                completion(nil, response, nil, nil)
            }
            
            // processing data
            if let data = data {
                
                do {
                    
                    let currentData = try JSONDecoder().decode([CurrentData].self, from: data)
                    var entityCompanies: [EntityCompany] = []
                    
                    DispatchQueue.main.async {
                        currentData.forEach({ company in
                            guard let entityCompany = EntityCompany(data: company) else { return }
                            entityCompanies.append(entityCompany)
                        })
                        
                        completion(entityCompanies, nil, nil, nil)
                    }
                    
                } catch {
                    
                    completion(nil, nil, nil, nil)
                }
            }
        }.resume()
    }
}
