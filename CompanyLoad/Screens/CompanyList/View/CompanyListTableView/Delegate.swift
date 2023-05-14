//
//  Delegate.swift
//  CompanyLoad
//
//  Created by Иван Тарасенко on 11.05.2023.
//

import UIKit

final class CompanyListTableViewDelegate: NSObject, UITableViewDelegate {
    
    var onScrollAction: (() -> Void)?
    
    var isEndOfList: Bool = false
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 285
    }
    
     func scrollViewDidScroll(_ scrollView: UIScrollView) {
         if scrollView.contentOffset.y + scrollView.frame.height >= scrollView.contentSize.height {
             if !isEndOfList {
                 onScrollAction?()
                 isEndOfList = true
             }
         }
     }
}
