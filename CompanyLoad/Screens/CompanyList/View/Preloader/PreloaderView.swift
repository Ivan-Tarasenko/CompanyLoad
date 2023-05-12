//
//  PreloaderView.swift
//  CompanyLoad
//
//  Created by Иван Тарасенко on 12.05.2023.
//

import UIKit
import SnapKit

final class PreloaderView: UIView {
    
    private let spinning = SpinningView()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.text = "Подгрузка компаний"
        label.textColor = R.Colors.highlightTextColor
        label.font = .systemFont(ofSize: 18, weight: .light)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        addedSubview()
        addedConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Public method
extension PreloaderView {
    
    func startAnivation() {
        spinning.startAnimate()
    }
    
    func stopAnivation() {
        spinning.stopAnimate()
    }
}

// MARK: - Private method
private extension PreloaderView {
    
    // MARK: - Configure view
    func configureView() {
       
       backgroundColor = .clear
    }
    
    func addedSubview() {
        addSubview(spinning)
        addSubview(textLabel)
    }
    
    func addedConstraint() {
        spinning.snp.makeConstraints { make in
            make.width.height.equalTo(50)
            make.centerX.equalTo(self)
            make.top.equalTo(self).offset(20)
        }
        textLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.top.equalTo(spinning.snp.bottom).offset(20)
        }
    }
}
