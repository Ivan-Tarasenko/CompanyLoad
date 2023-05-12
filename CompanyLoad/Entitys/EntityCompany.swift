//
//  EntityCompany.swift
//  CompanyLoad
//
//  Created by Иван Тарасенко on 12.05.2023.
//

import Foundation

struct EntityCompany {
    var company: Company
    var customerMarkParameters: CustomerMarkParameters
    var mobileAppDashboard: MobileAppDashboard

    init(data: WelcomeElement) {
        self.company = data.company
        self.customerMarkParameters = data.customerMarkParameters
        self.mobileAppDashboard = data.mobileAppDashboard
    }
}
