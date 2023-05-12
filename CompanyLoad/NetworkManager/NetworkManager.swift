//
//  NetworkManager.swift
//  CompanyLoad
//
//  Created by Иван Тарасенко on 12.05.2023.
//

import Foundation
import UIKit

protocol NetworkManagerProtocol: AnyObject {
//    func fetchData(completion: @escaping ([String: Currency]?, Error?) -> Void)
}

final class NetworkManager: NetworkManagerProtocol {
    
    var image = UIImage()
    var urlImage = String()
    
    // MARK: - Fetch data
//    func fetchData(completion: @escaping () -> Void) {
//        guard let URL = URL(string: urlString) else { return }
//        let session = URLSession(configuration: .default)
//
//        let task = session.dataTask(with: URL) { data, response, error in
//
//            var data = data
//
//            if error != nil {
//
//
//
//            }
//
//            if let httpResponse = response as? HTTPURLResponse {
//
//                    print(httpResponse.statusCode)
//
//
//
//               }
//
//            if let data = data {
//
//                if let currencyEntity =  self.parseJSON(withData: data) {
//                    DispatchQueue.main.async {
//
//                    }
//                }
//            }
//        }
//        task.resume()
//    }

    func fetchData() {
        let parameters = "{\n\t\"offset\": 0\n}"
        let postData = parameters.data(using: .utf8)

        var request = URLRequest(url: URL(string: "http://dev.bonusmoney.pro/mobileapp/getAllCompaniesLong")!,
                                 timeoutInterval: Double.infinity)
        request.addValue("123", forHTTPHeaderField: "TOKEN")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        request.httpMethod = "POST"
        request.httpBody = postData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
         
            if let httpResponse = response as? HTTPURLResponse {

                    print("/////////////\(httpResponse.statusCode)")
                
               }

            guard let data = data else {
                print("/////////////////\(String(describing: error))/////////////////")
                return
            }
            let welcome = try? JSONDecoder().decode(Welcome.self, from: data)
            
            self.urlImage = (welcome?[0].mobileAppDashboard.logo)!
            
            print(welcome?[0].mobileAppDashboard.logo)
//            print(String(data: data, encoding: .utf8)!)
            
            self.getImage()
        }

        task.resume()

    }
    
    func getImage() {
        
        if !urlImage.isEmpty {
            
            let url = URL(string: urlImage)!
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                
                if let data = data {
                    DispatchQueue.main.async {
                        self.image = UIImage(data: data) ?? UIImage()
                    }
                }
            }.resume()
        }
    }
    
    
    
    
    
    private func parseJSON(withData data: Data) -> Welcome? {
        let decoder = JSONDecoder()
        do {
            let currentDate = try decoder.decode(Welcome.self, from: data)
//            guard let currencyEntity = CurrencyEntity(currencyEntity: currentDate) else { return nil }
//            return currencyEntity
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
}

