//
//  LibraryDetailView.swift
//  Wenderlich Interview Demo
//
//  Created by Koty Stannard on 2/3/22.
//

import UIKit

class LibraryDetailView: UIView {
    
    let techLabel = UILabel()
    let titleLabel = UILabel()
    
    let contentInfoStack = UIStackView()
    let dateLabel = UILabel()
    let difficultyLabel = UILabel()
    let durationLabel = UILabel()
    
    let buttonStackView = UIStackView()
    let downloadButton = UIButton(type: .system)
    let bookmarkButton = UIButton(type: .system)
    
    let descriptionLabel = UILabel()
    let authorLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LibraryDetailView {
    func style() {
        backgroundColor = .white
        
        techLabel.translatesAutoresizingMaskIntoConstraints = false
        techLabel.font =  UIFont.preferredFont(forTextStyle: .body)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        titleLabel.numberOfLines = 2
        
        setupArticleInfoStackView()
        setupButtonStackView()
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = UIFont.preferredFont(forTextStyle: .body)
        descriptionLabel.numberOfLines = 0
        
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.font = UIFont.preferredFont(forTextStyle: .body)
        authorLabel.numberOfLines = 0
        
        addSubview(techLabel)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(authorLabel)
        
    }
    
    func setupArticleInfoStackView() {
        contentInfoStack.translatesAutoresizingMaskIntoConstraints = false
        contentInfoStack.axis = .horizontal
        contentInfoStack.alignment = .leading
        contentInfoStack.distribution = .fillProportionally
        
        [dateLabel, difficultyLabel, durationLabel].forEach { label in
            label.font = UIFont.preferredFont(forTextStyle: .body)
            contentInfoStack.addArrangedSubview(label)
        }
        
        addSubview(contentInfoStack)
    }
    
    func setupButtonStackView() {
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .equalCentering
        buttonStackView.alignment = .leading
        
        downloadButton.setImage(UIImage(systemName: "arrow.down.circle.fill")?.withRenderingMode(.alwaysOriginal), for: .normal)
        bookmarkButton.setImage(UIImage(systemName: "bookmark.fill")?.withRenderingMode(.alwaysOriginal), for: .normal)
        
        buttonStackView.addArrangedSubview(downloadButton)
        buttonStackView.addArrangedSubview(bookmarkButton)
        
        addSubview(buttonStackView)
    }
    
    func layout() {
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            
            techLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            techLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            techLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            
            titleLabel.topAnchor.constraint(equalTo: techLabel.bottomAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            
            contentInfoStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            contentInfoStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            contentInfoStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            
            buttonStackView.topAnchor.constraint(equalTo: contentInfoStack.bottomAnchor, constant: padding),
            buttonStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding + 6),
            buttonStackView.widthAnchor.constraint(equalToConstant: 75),
            
            descriptionLabel.topAnchor.constraint(equalTo: buttonStackView.bottomAnchor, constant: padding * 2),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            
            authorLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: padding),
            authorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            authorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding)
        ])
    }
}

