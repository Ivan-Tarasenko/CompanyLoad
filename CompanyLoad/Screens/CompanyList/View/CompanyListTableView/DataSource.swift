//
//  DataSource.swift
//  CompanyLoad
//
//  Created by Иван Тарасенко on 11.05.2023.
//

import UIKit

final class CompanyListTableViewDataSource: NSObject, UITableViewDataSource {
    
    let net = NetworkManager()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CompanyListCell.identifier, for: indexPath)
                as? CompanyListCell else { fatalError("Cell nil") }
        
        
        cell.installScoreLabel(text: "6000 баллов")
        
        return cell
    }
}
