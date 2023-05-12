//
//  EntityCompany.swift
//  CompanyLoad
//
//  Created by Иван Тарасенко on 12.05.2023.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - WelcomeElement
struct WelcomeElement: Codable {
    let company: Company
    let customerMarkParameters: CustomerMarkParameters
    let mobileAppDashboard: MobileAppDashboard
}

// MARK: - Company
struct Company: Codable {
    let companyID: String

    enum CodingKeys: String, CodingKey {
        case companyID = "companyId"
    }
}

// MARK: - CustomerMarkParameters
struct CustomerMarkParameters: Codable {
    let loyaltyLevel: LoyaltyLevel
    let mark: Int
}

// MARK: - LoyaltyLevel
struct LoyaltyLevel: Codable {
    let number: Int
    let name: String
    let requiredSum, markToCash, cashToMark: Int
}

// MARK: - MobileAppDashboard
struct MobileAppDashboard: Codable {
    let companyName: String
    let logo: String
    let backgroundColor, mainColor, cardBackgroundColor, textColor: String
    let highlightTextColor, accentColor: String
}

typealias Welcome = [WelcomeElement]
