//
//  ViewModel.swift
//  CompanyLoad
//
//  Created by Иван Тарасенко on 12.05.2023.
//

import Foundation
import UIKit

enum NetworkError: String {
    case answer401 = "Ошибка авторизации"
    case answer500 = "Все упало"
    case defaultError = "Неизвестная ошибка"
}

protocol ViewModelProtocol: AnyObject {
    var onUpDataCompany: (([EntityCompany]) -> Void)? { get set }
    var onDataEmpty: ((Bool) -> Void)? { get set }
    var onRequestError: ((String?) -> Void)? { get set }
    
    func fetchData(page: Int)
}

final class ViewModel: ViewModelProtocol {
    
    var onUpDataCompany: (([EntityCompany]) -> Void)?
    var onDataEmpty: ((Bool) -> Void)?
    var onRequestError: ((String?) -> Void)?

    private var companies: [EntityCompany]? = [] {
        didSet {
            if let companies = companies {
                onUpDataCompany?(companies)
            }
        }
    }
    
    private var isEmptyData: Bool = false {
        didSet {
            onDataEmpty?(isEmptyData)
        }
    }
    
    private var requestError: String? {
        didSet {
            onRequestError?(requestError)
        }
    }
    
    private let networkManager: NetworkManagerProtocol = NetworkManager()
    
    func fetchData(page: Int) {
        networkManager.loadingData(page: page) { [weak self] data, response, error, errorMassage  in
            guard let self else { return }
            
            // processing error
            if error != nil {
                print(error?.localizedDescription as Any)
            }
            
            // processing response
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200:
                    print("200")
                case 400:
                    self.requestError = errorMassage
                case 401:
                    self.requestError = NetworkError.answer401.rawValue
                case 500:
                    self.requestError = NetworkError.answer500.rawValue
                default:
                    self.requestError  = NetworkError.defaultError.rawValue
                }
            }
            
            // processing data
            if let data = data {
                
                if data.isEmpty {
                    self.isEmptyData = true
                    return
                }
                
                self.companies?.append(contentsOf: data)
                
            }
        }
    }
    
}
