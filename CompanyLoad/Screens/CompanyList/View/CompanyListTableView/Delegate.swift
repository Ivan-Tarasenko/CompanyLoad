//
//  Delegate.swift
//  CompanyLoad
//
//  Created by Иван Тарасенко on 11.05.2023.
//

import UIKit

final class CompanyListTableViewDelegate: NSObject, UITableViewDelegate {
    
    var onScrollAction: (() -> Void)?
    var onTapCell: ((Int) -> Void)?
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 285
    }
    
     func scrollViewDidScroll(_ scrollView: UIScrollView) {
         if scrollView.contentOffset.y + scrollView.frame.height >= scrollView.contentSize.height {
         }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        onScrollAction?()
        print("end")
    }
    
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        onTapCell?(indexPath.row)
//    }
}
