//
//  ArticleCell.swift
//  Wenderlich Interview Demo
//
//  Created by Koty Stannard on 1/19/22.
//

import UIKit

class ArticleCell: UITableViewCell {
    
    struct ViewModel {
        let name: String
        let description: String
        let contentType: String
    }
    
    let viewModel: ViewModel? = nil
    
    let stackView = UIStackView()
    let nameLabel = UILabel()
    let descriptionLabel = UILabel()
    let contentTypeLabel = UILabel()
    
    static let reuseid = "CustomCell"
    static let rowHeight: CGFloat = 200
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override var intrinsicContentSize: CGSize {
//        return CGSize(width: 200, height: 200)
//    }
}

extension ArticleCell {
    
    func setup() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.numberOfLines = 0
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        descriptionLabel.adjustsFontSizeToFitWidth = true
        descriptionLabel.numberOfLines = 0
        
        contentTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        contentTypeLabel.font = UIFont.preferredFont(forTextStyle: .body)
        contentTypeLabel.adjustsFontSizeToFitWidth = true
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .top
        stackView.spacing = 8
        
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(contentTypeLabel)
        
        contentView.addSubview(stackView)
    }
    
    func layout() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configure(with viewModel: ViewModel) {
        nameLabel.text = viewModel.name
        descriptionLabel.text = viewModel.description
        contentTypeLabel.text = viewModel.contentType
    }
}
