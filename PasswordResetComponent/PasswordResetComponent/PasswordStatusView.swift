//
//  PasswordStatusView.swift
//  PasswordResetComponent
//
//  Created by Koty Stannard on 6/23/22.
//

import UIKit

class PasswordStatusView: UIView {
    
    let stackView = UIStackView()
    let criteriaView = PasswordCriteriaView(criteriaText: "8-32 characters (no spaces)")
    let textLabel = UILabel()
    let criteriaView2 = PasswordCriteriaView(criteriaText: "uppercase letter(s) (A-Z)")
    let criteriaView3 = PasswordCriteriaView(criteriaText: "lowercase letter(s) (a-z)")
    let criteriaView4 = PasswordCriteriaView(criteriaText: "digit(s) (0-9)")
    let criteriaView5 = PasswordCriteriaView(criteriaText: "special character(s) (e.g. !@#$%^)")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 200)
    }
}

extension PasswordStatusView {
    
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemGray6
        
        criteriaView.translatesAutoresizingMaskIntoConstraints = false
        criteriaView2.translatesAutoresizingMaskIntoConstraints = false
        criteriaView3.translatesAutoresizingMaskIntoConstraints = false
        criteriaView4.translatesAutoresizingMaskIntoConstraints = false
        criteriaView5.translatesAutoresizingMaskIntoConstraints = false
        
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = "Use at least 3 of these 4 criteria when setting your password:"
        textLabel.adjustsFontSizeToFitWidth = true
        textLabel.numberOfLines = 0
        textLabel.textColor = .secondaryLabel
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
    }
    
    func layout() {
        stackView.addArrangedSubview(criteriaView)
        stackView.addArrangedSubview(textLabel)
        stackView.addArrangedSubview(criteriaView2)
        stackView.addArrangedSubview(criteriaView3)
        stackView.addArrangedSubview(criteriaView4)
        stackView.addArrangedSubview(criteriaView5)
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
}
