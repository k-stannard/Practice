//
//  ArticleDetailView.swift
//  Wenderlich Interview Demo
//
//  Created by Koty Stannard on 1/23/22.
//

import UIKit

class ArticleDetailView: UIView {
    
    let articleInfoStackView = UIStackView()
    let titleLabel = UILabel()
    let techLabel = UILabel()
    let descriptionLabel = UILabel()
    
    let detailInfoStackView = UIStackView()
    let accessLabel = UILabel()
    let articleDateLabel = UILabel()
    let articleLengthLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ArticleDetailView {
    
    func style() {
        setupArticleInfoStackView()
        setupDetailInfoStackView()
    }
    
    func setupArticleInfoStackView() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.preferredFont(forTextStyle: .body)
        titleLabel.adjustsFontSizeToFitWidth = true
        //titleLabel.numberOfLines = 0
        titleLabel.text = "TITLE"
        
        techLabel.translatesAutoresizingMaskIntoConstraints = false
        techLabel.font = UIFont.preferredFont(forTextStyle: .body)
        techLabel.text = "TECH STACK"
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = UIFont.preferredFont(forTextStyle: .body)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.text = "DESCRIPTION"
        
        articleInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        articleInfoStackView.axis = .vertical
        articleInfoStackView.alignment = .top
        articleInfoStackView.spacing = 8
        
        detailInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        
        articleInfoStackView.addArrangedSubview(titleLabel)
        articleInfoStackView.addArrangedSubview(techLabel)
        articleInfoStackView.addArrangedSubview(descriptionLabel)
        articleInfoStackView.addArrangedSubview(detailInfoStackView)
        
        addSubview(articleInfoStackView)
    }
    
    func setupDetailInfoStackView() {
        accessLabel.translatesAutoresizingMaskIntoConstraints = false
        accessLabel.font = UIFont.preferredFont(forTextStyle: .body)
        accessLabel.text = "ACCESS"
        
        articleDateLabel.translatesAutoresizingMaskIntoConstraints = false
        articleDateLabel.font = UIFont.preferredFont(forTextStyle: .body)
        articleDateLabel.adjustsFontSizeToFitWidth = true
        articleDateLabel.text = "DATE"
        
        articleLengthLabel.translatesAutoresizingMaskIntoConstraints = false
        articleLengthLabel.font = UIFont.preferredFont(forTextStyle: .body)
        articleLengthLabel.text = "ARTICLE LENGTH"
        
        detailInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        detailInfoStackView.axis = .horizontal
        detailInfoStackView.alignment = .top
        detailInfoStackView.spacing = 8
        
        detailInfoStackView.addArrangedSubview(accessLabel)
        detailInfoStackView.addArrangedSubview(articleDateLabel)
        detailInfoStackView.addArrangedSubview(articleLengthLabel)
    }
    
    func layout() {
        NSLayoutConstraint.activate([
            articleInfoStackView.topAnchor.constraint(equalTo: topAnchor),
            articleInfoStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            articleInfoStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            articleInfoStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
