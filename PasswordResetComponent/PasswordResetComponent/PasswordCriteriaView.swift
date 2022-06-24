//
//  PasswordCriteriaView.swift
//  PasswordResetComponent
//
//  Created by Koty Stannard on 6/23/22.
//

import UIKit

class PasswordCriteriaView: UIView {
    
    let stackView = UIStackView()
    let statusImageView = UIImageView()
    let criteriaLabel = UILabel()
    let criteriaText: String
    
    let checkmarkImage = UIImage(systemName: "checkmark.circle")?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
    let xmarkImage = UIImage(systemName: "xmark.circle")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
    let circleImage = UIImage(systemName: "circle")?.withTintColor(.tertiaryLabel, renderingMode: .alwaysOriginal)
    
    var isCriteriaMet: Bool = false {
        didSet {
            if isCriteriaMet {
                statusImageView.image = checkmarkImage
            } else {
                statusImageView.image = xmarkImage
            }
        }
    }
    
    func reset() {
        isCriteriaMet = false
        statusImageView.image = circleImage
    }
    
    init(criteriaText: String) {
        self.criteriaText = criteriaText
        
        super.init(frame: .zero)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 40)
    }
}

extension PasswordCriteriaView {
    
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        
        statusImageView.translatesAutoresizingMaskIntoConstraints = false
        statusImageView.image = circleImage
        
        criteriaLabel.translatesAutoresizingMaskIntoConstraints = false
        criteriaLabel.text = criteriaText
        criteriaLabel.textColor = .secondaryLabel
        criteriaLabel.adjustsFontSizeToFitWidth = true
    }
    
    func layout() {
        stackView.addArrangedSubview(statusImageView)
        stackView.addArrangedSubview(criteriaLabel)
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            statusImageView.heightAnchor.constraint(equalTo: statusImageView.widthAnchor),
            
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        statusImageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        criteriaLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
    }
}
