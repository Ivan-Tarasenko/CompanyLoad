//
//  Cell.swift
//  CompanyLoad
//
//  Created by Иван Тарасенко on 11.05.2023.
//

import UIKit
import SnapKit
import Kingfisher

final class CompanyListCell: UITableViewCell {
    
    var onHideButtonPressed: (() -> Void)?
    var onTrashButtonPressed: (() -> Void)?
    var onDetailButtonPressed: (() -> Void)?
    
    var massage: String?
    
    // MARK: - Outlets
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = R.Colors.highlightTextColor
        label.font = UIFont.systemFont(ofSize: 25)
        return label
    }()
    
    private let imageCard: UIImageView = {
        let iView = UIImageView()
        iView.contentMode = .scaleAspectFit
        iView.layer.cornerRadius = 47 / 2
        iView.clipsToBounds = true
        return iView
    }()
    
    private let topSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = R.Colors.textColor
        return view
    }()
    
    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    private let cashbackLabel: UILabel = {
        let label = UILabel()
        label.text = "Keшбэк"
        label.textColor = R.Colors.textColor
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let percentCachbackLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Noto Sans Oriya", size: 19)
        return label
    }()
    
    private let levelLabel: UILabel = {
        let label = UILabel()
        label.text = "Уровень"
        label.textColor = R.Colors.textColor
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let disriptionLevelLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Noto Sans Oriya", size: 19)
        return label
    }()
    
    private let bottomSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = R.Colors.textColor
        return view
    }()
    
    private let hideCardButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "eye_white"), for: .normal)
        button.tintColor = R.Colors.mainColor
        return button
    }()
    
    private let trashCardButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "trash_white"), for: .normal)
        button.tintColor = R.Colors.accentColor
        return button
    }()
    
    private let detailCardButton: UIButton = {
        let button = UIButton()
        button.setTitle("Подробнеe", for: .normal)
        button.setTitleColor(R.Colors.mainColor, for: .normal)
        button.backgroundColor = R.Colors.backgroundColor
        button.layer.cornerRadius = 12
        return button
    }()
    
    private let mainTitleStackView = UIStackView()
    private let cachbackStackView = UIStackView()
    private let levelStackView = UIStackView()
    private let buttonStackView = UIStackView()
    
    static var identifier: String {
        return String(describing: self)
    }
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
        setMainTitleStackView()
        setCachbackStackView()
        setLevelStackView()
        setButtonStackView()
        addedSubview()
        addedConstraint()
        addedTarget()
        createAccesibilityIdentifier()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = CGRect(x: 20, y: 10, width: bounds.width - 40, height: bounds.height - 20)
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}

// MARK: - Public method
extension CompanyListCell {
    
    func installCompanyName(name: String) {
        titleLabel.text = name
    }
    
    func installLogo(_ url: String) {
        let url = URL(string: url)
        imageCard.kf.setImage(with: url) { result in
            switch result {
            case .failure:
                self.imageCard.image = UIImage(named: "imageCard")
            case .success:
                break
            }
        }
    }
    
    func installCachback(_ sum: Int) {
        percentCachbackLabel.text = "\(sum)%"
    }
    
    func installLevel(_ text: String) {
        disriptionLevelLabel.text = text
    }
    
    func installScoreLabel(text: String) {
        let attributedText = NSMutableAttributedString(string: text)
        
        let digitsAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: R.Colors.highlightTextColor,
            .font: UIFont.systemFont(ofSize: 28)
        ]
        
        let lettersAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: R.Colors.textColor
        ]
        
        for index in attributedText.string.indices {
            let character = attributedText.string[index]
            let charConteins = character.unicodeScalars.first
            let startIndex = attributedText.string.distance(from: attributedText.string.startIndex, to: index)
            
            if charConteins != nil {
                
                let attributes = CharacterSet.decimalDigits.contains(charConteins!) ? digitsAttributes : lettersAttributes
                
                let range = NSRange(location: startIndex, length: 1)
                
                attributedText.addAttributes(attributes, range: range)
            }
        }
        scoreLabel.attributedText = attributedText
    }
}

// MARK: - Button action
@objc extension CompanyListCell {
    
    func hideCardButtonAction() {
        AlertService.shared.showAlert(title: "Кнопка скрытия ячейки", massage: massage ?? "")
    }
    
    func trashCardButtonAction() {
        AlertService.shared.showAlert(title: "Кнопка удаления ячейки", massage: massage ?? "")
    }
    
    func detailCardButtonAction() {
        AlertService.shared.showAlert(title: "Кнопка Подробнее", massage: massage ?? "")
    }
}

// MARK: - Private method
private extension CompanyListCell {
    
    // MARK: - Configure View
    func configureView() {
        backgroundColor = .clear
        selectionStyle = .none
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 30
    }
    
    func addedTarget() {
        hideCardButton.addTarget(self, action: #selector(hideCardButtonAction), for: .touchUpInside)
        trashCardButton.addTarget(self, action: #selector(trashCardButtonAction), for: .touchUpInside)
        detailCardButton.addTarget(self, action: #selector(detailCardButtonAction), for: .touchUpInside)
    }
    
    func setMainTitleStackView() {
        mainTitleStackView.axis = .horizontal
        mainTitleStackView.distribution = .fill
        mainTitleStackView.alignment = .fill
        mainTitleStackView.addArrangedSubview(titleLabel)
        mainTitleStackView.addArrangedSubview(imageCard)
    }
    
    func setCachbackStackView() {
        cachbackStackView.axis = .vertical
        cachbackStackView.alignment = .leading
        cachbackStackView.addArrangedSubview(cashbackLabel)
        cachbackStackView.addArrangedSubview(percentCachbackLabel)
    }
    
    func setLevelStackView() {
        levelStackView.axis = .vertical
        levelStackView.alignment = .leading
        levelStackView.addArrangedSubview(levelLabel)
        levelStackView.addArrangedSubview(disriptionLevelLabel)
    }
    
    func setButtonStackView() {
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .fill
        buttonStackView.alignment = .center
        buttonStackView.spacing = 50
        buttonStackView.addArrangedSubview(hideCardButton)
        buttonStackView.addArrangedSubview(trashCardButton)
        buttonStackView.addArrangedSubview(detailCardButton)
    }
    
    func addedSubview() {
        contentView.addSubview(mainTitleStackView)
        contentView.addSubview(topSeparator)
        contentView.addSubview(scoreLabel)
        contentView.addSubview(cachbackStackView)
        contentView.addSubview(levelStackView)
        contentView.addSubview(bottomSeparator)
        contentView.addSubview(buttonStackView)
    }
    
    // MARK: - Install constraint
    func addedConstraint() {
        mainTitleStackView.snp.makeConstraints { make in
            make.height.equalTo(47)
            make.leading.top.equalTo(R.Sizes.redConstraint)
            make.trailing.equalTo(-R.Sizes.redConstraint)
        }
        
        imageCard.snp.makeConstraints { make in
            make.width.height.equalTo(47)
        }
        
        topSeparator.snp.makeConstraints { make in
            make.width.equalTo(Int(self.bounds.width) + R.Sizes.redConstraint)
            make.height.equalTo(1)
            make.bottom.equalTo(imageCard.snp.bottom).offset(R.Sizes.yellowConstraint)
            make.centerX.equalTo(self)
        }
        
        scoreLabel.snp.makeConstraints { make in
            make.top.equalTo(topSeparator.snp.bottom).offset(R.Sizes.redConstraint)
            make.leading.equalTo(self.contentView).offset(R.Sizes.redConstraint)
        }
        
        cachbackStackView.snp.makeConstraints { make in
            make.width.height.equalTo(60)
            make.top.equalTo(scoreLabel.snp.bottom)
            make.leading.equalTo(self.contentView).offset(R.Sizes.redConstraint)
        }
        
        levelStackView.snp.makeConstraints { make in
            make.width.equalTo(250)
            make.height.equalTo(60)
            make.top.equalTo(scoreLabel.snp.bottom)
            make.leading.equalTo(cachbackStackView.snp.trailing).offset(R.Sizes.blueConstraint)
        }
        
        bottomSeparator.snp.makeConstraints { make in
            make.width.equalTo(Int(self.bounds.width) + R.Sizes.redConstraint)
            make.height.equalTo(1)
            make.bottom.equalTo(detailCardButton.snp.top).offset(-R.Sizes.yellowConstraint)
            make.centerX.equalTo(self.contentView)
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.height.equalTo(47)
            make.leading.equalTo(R.Sizes.redConstraint * 2)
            make.trailing.bottom.equalTo(-R.Sizes.redConstraint)
        }
        
        hideCardButton.snp.makeConstraints { make in
            make.width.height.equalTo(23)
        }
        
        trashCardButton.snp.makeConstraints { make in
            make.width.height.equalTo(23)
        }
        
        detailCardButton.snp.makeConstraints { make in
            make.height.equalTo(buttonStackView)
        }
    }
}

// MARK: - AccessibilityIdentifier
private extension CompanyListCell {
    func createAccesibilityIdentifier() {
        titleLabel.accessibilityIdentifier = "title_Label"
        imageCard.accessibilityIdentifier = "image_Card"
        topSeparator.accessibilityIdentifier = "top_Separator"
        scoreLabel.accessibilityIdentifier = "score_Label"
        cashbackLabel.accessibilityIdentifier = "cashback_Label"
        percentCachbackLabel.accessibilityIdentifier = "percent_Cachback_Label"
        levelLabel.accessibilityIdentifier = "level_Label"
        disriptionLevelLabel.accessibilityIdentifier = "disription_Level_Label"
        bottomSeparator.accessibilityIdentifier = "bottom_Separator"
        hideCardButton.accessibilityIdentifier = "hide_Card_Button"
        trashCardButton.accessibilityIdentifier = "trash_Card_Button"
        detailCardButton.accessibilityIdentifier = "detail_Card_Button"
    }
}
