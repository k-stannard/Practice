//
//  ContentDetailView.swift
//  Wenderlich Interview Demo
//
//  Created by Koty Stannard on 1/23/22.
//

import UIKit

class ContentDetailView: UIView {
    
    let contentInfoStackView = UIStackView()
    let titleLabel = UILabel()
    let techLabel = UILabel()
    
    let artworkImageView = ContentImageView(frame: .zero)
    let descriptionLabel = UILabel()
    
    let detailInfoStackView = UIStackView()
    let accessLabel = UILabel()
    let dateLabel = UILabel()
    let durationLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ContentDetailView {
    
    func style() {
        setupContentInfoStackView()
        setupDetailInfoStackView()
    }
    
    func setupContentInfoStackView() {
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
        
        contentInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        contentInfoStackView.axis = .vertical
        contentInfoStackView.alignment = .top
        contentInfoStackView.spacing = 8
        
        detailInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentInfoStackView.addArrangedSubview(titleLabel)
        contentInfoStackView.addArrangedSubview(techLabel)
        
        addSubview(contentInfoStackView)
        addSubview(descriptionLabel)
        addSubview(artworkImageView)
    }
    
    func setupDetailInfoStackView() {
        accessLabel.translatesAutoresizingMaskIntoConstraints = false
        accessLabel.font = UIFont.preferredFont(forTextStyle: .body)
        accessLabel.text = "ACCESS"
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.font = UIFont.preferredFont(forTextStyle: .body)
        dateLabel.adjustsFontSizeToFitWidth = true
        dateLabel.text = "DATE"
        
        durationLabel.translatesAutoresizingMaskIntoConstraints = false
        durationLabel.font = UIFont.preferredFont(forTextStyle: .body)
        durationLabel.text = "ARTICLE LENGTH"
        
        detailInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        detailInfoStackView.axis = .horizontal
        detailInfoStackView.alignment = .top
        detailInfoStackView.spacing = 8
        
        detailInfoStackView.addArrangedSubview(accessLabel)
        detailInfoStackView.addArrangedSubview(dateLabel)
        detailInfoStackView.addArrangedSubview(durationLabel)
        
        addSubview(detailInfoStackView)
    }
    
    func layout() {
        NSLayoutConstraint.activate([
            contentInfoStackView.topAnchor.constraint(equalTo: topAnchor),
            contentInfoStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentInfoStackView.trailingAnchor.constraint(equalTo: artworkImageView.leadingAnchor, constant: -8),
            
            artworkImageView.topAnchor.constraint(equalTo: topAnchor),
            artworkImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            artworkImageView.widthAnchor.constraint(equalToConstant: 75),
            artworkImageView.heightAnchor.constraint(equalToConstant: 75),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: contentInfoStackView.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: artworkImageView.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: detailInfoStackView.topAnchor, constant: -8),
            
            detailInfoStackView.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            detailInfoStackView.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor),
            detailInfoStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
