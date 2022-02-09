//
//  CustomCell.swift
//  CollectionViews
//
//  Created by Koty Stannard on 2/8/22.
//

import UIKit

class CustomCell: UICollectionViewCell {
    
    struct ViewModel {
        
    }
    
    let viewModel: ViewModel? = nil
    
    static let reuseid = "CustomCell"
    
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 50, height: 50)
    }
}

extension CustomCell {
    
    func setup() {
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)
    }
    
    func layout() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
        ])
    }
    
    func configure(with viewModel: ViewModel) {
        
    }
}
