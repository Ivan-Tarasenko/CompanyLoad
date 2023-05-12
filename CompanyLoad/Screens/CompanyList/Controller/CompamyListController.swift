//
//  CompamyListController.swift
//  CompanyLoad
//
//  Created by Иван Тарасенко on 11.05.2023.
//

import UIKit
import SnapKit

class CompamyListController: UIViewController {
    
    // MARK: - Outlets
    private let cardManagementButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Управление картами", for: .normal)
        button.setTitleColor(R.Colors.mainColor, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 24)
        return button
    }()
    
    private var tableView = UITableView()
    
    // MARK: - Variables
    private let dataSource: CompanyListTableViewDataSource
    private let delegate: CompanyListTableViewDelegate
    
    let networkManaager = NetworkManager()

    // MARK: - Lifecycle
    init(dataSourse: CompanyListTableViewDataSource, delegate: CompanyListTableViewDelegate) {
        self.dataSource = dataSourse
        self.delegate = delegate
        super .init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkManaager.fetchData()
        
        configureView()
        configureTableView()
        addedSubview()
        addedConstraint()
        bing()
        showPreloader()
    }
}

// MARK: - Actions
extension CompamyListController {
    
    func showPreloader() {
        delegate.onScrollAction = {
            let footerView = PreloaderView()
            
            footerView.startAnivation()
            footerView.frame.size.height = 150
            self.tableView.tableFooterView = footerView
            
        }
    }
}

// MARK: - Private method
private extension CompamyListController {
    
    // MARK: - Configuration
    func configureView() {
//        view.backgroundColor = R.Colors.backgroundColor
    }
    
   func configureTableView() {
       tableView.backgroundColor = R.Colors.backgroundColor
        tableView.separatorStyle = .none
        tableView.register(CompanyListCell.self, forCellReuseIdentifier: CompanyListCell.identifier)
    }
    
    func addedSubview() {
        view.addSubview(cardManagementButton)
        view.addSubview(tableView)
    }
    
     func bing() {
        tableView.dataSource = dataSource
        tableView.delegate = delegate
//        dataSource.viewModel = viewModel
    }
    
    func addedConstraint() {
        cardManagementButton.snp.makeConstraints { make in
            make.height.equalTo(45)
            make.leading.top.equalTo(view.safeAreaLayoutGuide)
            make.trailing.equalTo(view)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(cardManagementButton.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
