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
        let date: Date
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ArticleCell {
    
    func setup() {
        articleDetailView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(articleDetailView)
    }
    
    func layout() {
        NSLayoutConstraint.activate([
            articleDetailView.topAnchor.constraint(equalTo: contentView.topAnchor),
            articleDetailView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            articleDetailView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            articleDetailView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
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
