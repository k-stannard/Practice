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
    
    let artworkImageView = UIImageView()
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
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.numberOfLines = 2
        titleLabel.text = "TITLE"
        
        techLabel.translatesAutoresizingMaskIntoConstraints = false
        techLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        techLabel.text = "TECH STACK"
        
        artworkImageView.translatesAutoresizingMaskIntoConstraints = false
        artworkImageView.image = UIImage(named: "temp")
        artworkImageView.layer.cornerRadius = 12
        artworkImageView.clipsToBounds = true
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = UIFont.preferredFont(forTextStyle: .body)
        descriptionLabel.numberOfLines = 4
        descriptionLabel.text = "DESCRIPTION"
        
        articleInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        articleInfoStackView.axis = .vertical
        articleInfoStackView.alignment = .top
        articleInfoStackView.spacing = 8
        
        detailInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        
        articleInfoStackView.addArrangedSubview(titleLabel)
        articleInfoStackView.addArrangedSubview(techLabel)
        
        addSubview(articleInfoStackView)
        addSubview(descriptionLabel)
        addSubview(artworkImageView)
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
        
        addSubview(detailInfoStackView)
    }
    
    func layout() {
        NSLayoutConstraint.activate([
            articleInfoStackView.topAnchor.constraint(equalTo: topAnchor),
            articleInfoStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            articleInfoStackView.trailingAnchor.constraint(equalTo: artworkImageView.leadingAnchor, constant: -8),
            
            artworkImageView.topAnchor.constraint(equalTo: topAnchor),
            artworkImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            artworkImageView.widthAnchor.constraint(equalToConstant: 75),
            artworkImageView.heightAnchor.constraint(equalToConstant: 75),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: articleInfoStackView.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: artworkImageView.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: detailInfoStackView.topAnchor, constant: -8),
            
            detailInfoStackView.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            detailInfoStackView.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor),
            detailInfoStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
