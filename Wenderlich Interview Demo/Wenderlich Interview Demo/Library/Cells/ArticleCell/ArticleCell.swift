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
        let techStack: String
        let access: String
        let date: String
        let length: String
    }
    
    let viewModel: ViewModel? = nil
    
    let articleDetailView = ArticleDetailView()
    
    static let reuseid = "CustomCell"
    static let rowHeight: CGFloat = 250
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
        layout()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ArticleCell {
    
    func setup() {
        articleDetailView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(articleDetailView)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 12
        backgroundColor = UIColor.init(red: 217/255, green: 242/255, blue: 255/255, alpha: 1)
    }
    
    func layout() {
        NSLayoutConstraint.activate([
            articleDetailView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            articleDetailView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            articleDetailView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            articleDetailView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    func configure(with viewModel: ViewModel) {
        articleDetailView.titleLabel.text = viewModel.name
        articleDetailView.techLabel.text = viewModel.techStack
        articleDetailView.descriptionLabel.text = viewModel.description
        articleDetailView.accessLabel.text = viewModel.access
        articleDetailView.articleDateLabel.text = "\(viewModel.date)"
        articleDetailView.articleLengthLabel.text = viewModel.length
    }
}
