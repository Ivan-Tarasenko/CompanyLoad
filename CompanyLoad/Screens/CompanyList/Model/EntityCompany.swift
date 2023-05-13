//
//  EntityCompany.swift
//  CompanyLoad
//
//  Created by Иван Тарасенко on 12.05.2023.
//

import Foundation
import UIKit

struct EntityCompany {
    var idCompany: String
    var name: String
    var urlLogo: String
    var score: Int
    var cashback: Int
    var level: String
    
    init?(data: CurrentData) {
        self.idCompany = data.company.companyID
        self.name = data.mobileAppDashboard.companyName
        self.urlLogo = data.mobileAppDashboard.logo
        self.score = data.customerMarkParameters.mark
        self.cashback = data.customerMarkParameters.loyaltyLevel.cashToMark
        self.level = data.customerMarkParameters.loyaltyLevel.name
    }
}
