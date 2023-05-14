//
//  SpinningView.swift
//  CompanyLoad
//
//  Created by Иван Тарасенко on 12.05.2023.
//

import UIKit

final class SpinningView: UIView {
    
    private let spinningCircle = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configereView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startAnimate() {
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear) {
            self.transform = CGAffineTransform(rotationAngle: .pi)
        } completion: { _ in
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear) {
                self.transform = CGAffineTransform(rotationAngle: 0)
            } completion: { _ in
                self.startAnimate()
            }
        }

    }
    
    private func configereView() {
        frame = CGRect(x: 0, y: 0, width: 45, height: 45)
        
        let rect = self.bounds
        let circularPath = UIBezierPath(ovalIn: rect)
        
        spinningCircle.path = circularPath.cgPath
        spinningCircle.fillColor = UIColor.clear.cgColor
        spinningCircle.strokeColor = R.Colors.highlightTextColor.cgColor
        spinningCircle.lineWidth = 5
        spinningCircle.strokeEnd = 0.30
        spinningCircle.lineCap = .square
        
        self.layer.addSublayer(spinningCircle)
    }
}
