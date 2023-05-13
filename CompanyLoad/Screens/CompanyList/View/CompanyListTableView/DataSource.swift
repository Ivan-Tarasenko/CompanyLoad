//
//  DataSource.swift
//  CompanyLoad
//
//  Created by Иван Тарасенко on 11.05.2023.
//

import UIKit

final class CompanyListTableViewDataSource: NSObject, UITableViewDataSource {
    
    var companies: [EntityCompany] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CompanyListCell.identifier, for: indexPath)
                as? CompanyListCell else { fatalError("Cell nil") }
        
        let comdanyName = companies[indexPath.row].name
        let logo = companies[indexPath.row].urlLogo
        let score = companies[indexPath.row].score
        let cashback = companies[indexPath.row].cashback
        let level = companies[indexPath.row].level
        
        cell.massage = companies[indexPath.row].idCompany
        cell.installCompanyName(name: comdanyName)
        cell.installLogo(logo)
        cell.installScoreLabel(text: "\(score) баллов")
        cell.installCachback(cashback)
        cell.installLevel(level)

        return cell
    }
}
