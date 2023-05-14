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
    
    // MARK: - Variables
    var dataSource: CompanyListTableViewDataSource
    var delegate: CompanyListTableViewDelegate
    private let viewModel: ViewModelProtocol = ViewModel()
    private var tableView = UITableView()
    private var loadPage: Int = 0
    private var isEmptyData: Bool = false
    
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
        bing()
        configureView()
        configureTableView()
        addedSubview()
        addedConstraint()
        showPreloader()
        dataReloading()
        cancelReloading()
        handleError()
        viewModel.fetchData(page: loadPage)
    }
}

// MARK: - Data processing
private extension CompamyListController {
    func bing() {
        viewModel.onUpDataCompany = { [weak self] data in
            guard let self else { return }
            self.tableView.dataSource = self.dataSource
            self.tableView.delegate = self.delegate
            self.dataSource.companies = data
            self.delegate.isEndOfList = self.isEmptyData
            self.tableView.reloadData()
        }
    }
    
    func cancelReloading() {
        viewModel.onDataEmpty = { [weak self] isEmpty in
            guard let self else { return }
            if isEmpty {
                self.isEmptyData = true
                self.tableView.tableFooterView = nil
                self.tableView.reloadData()
            }
        }
    }
    
    func dataReloading() {
        delegate.onScrollAction = { [weak self] in
            guard let self else { return }
            self.loadPage += 1
            self.viewModel.fetchData(page: self.loadPage)
        }
    }
    
    func showPreloader() {
        let footerView = PreloaderView()
        footerView.frame.size.height = 150
        tableView.tableFooterView = footerView
    }
    
    func handleError() {
        viewModel.onRequestError = { string in
            if let string = string {
                DispatchQueue.main.async {
                    AlertService.shared.showAlert(title: "Error", massage: string)
                    self.tableView.tableFooterView = nil
                }
            }
        }
    }
}

// MARK: - Private method
private extension CompamyListController {
    
    // MARK: - Configuration
    func configureView() {
        view.backgroundColor = .white
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
    
    func addedConstraint() {
        cardManagementButton.snp.makeConstraints { make in
            make.height.equalTo(50)
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
