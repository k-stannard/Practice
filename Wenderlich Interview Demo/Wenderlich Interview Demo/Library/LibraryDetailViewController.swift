//
//  LibraryDetailViewController.swift
//  Wenderlich Interview Demo
//
//  Created by Koty Stannard on 1/26/22.
//

import UIKit

import UIKit

class LibraryDetailViewController: UIViewController {
    
    var content: ArticlesAndVideos
    
    let artworkImage = UIImageView()
    let techLabel = UILabel()
    let titleLabel = UILabel()
    
    let contentInfoStack = UIStackView()
    let dateLabel = UILabel()
    let difficultyLabel = UILabel()
    let durationLabel = UILabel()
    
    let buttonStackView = UIStackView()
    let downloadButton = UIButton()
    let bookmarkButton = UIButton()
    
    let descriptionLabel = UILabel()
    let authorLabel = UILabel()
    
    init(content: ArticlesAndVideos) {
        self.content = content
        self.techLabel.text = content.technologyTripleString
        self.titleLabel.text = content.name
        self.dateLabel.text = content.releasedAt
        self.difficultyLabel.text = content.difficulty
        self.durationLabel.text = "\(content.duration)"
        self.descriptionLabel.text = content.descriptionPlainText
        self.authorLabel.text = content.contributorString
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}

extension LibraryDetailViewController {
    func style() {
        view.backgroundColor = .white
        navigationItem.largeTitleDisplayMode = .never
        
        artworkImage.translatesAutoresizingMaskIntoConstraints = false
        artworkImage.image = UIImage(named: "temp")
        
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
        
        view.addSubview(artworkImage)
        view.addSubview(techLabel)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(authorLabel)
        
    }
    
    func setupArticleInfoStackView() {
        contentInfoStack.translatesAutoresizingMaskIntoConstraints = false
        contentInfoStack.axis = .horizontal
        contentInfoStack.alignment = .leading
        contentInfoStack.distribution = .equalSpacing
        
        [dateLabel, difficultyLabel, durationLabel].forEach { label in
            label.font = UIFont.preferredFont(forTextStyle: .body)
            contentInfoStack.addArrangedSubview(label)
        }
        
        view.addSubview(contentInfoStack)
    }
    
    func setupButtonStackView() {
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .equalCentering
        buttonStackView.alignment = .leading
        
        downloadButton.setImage(UIImage(systemName: "square.and.arrow.down.fill"), for: .normal)
        bookmarkButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        
        buttonStackView.addArrangedSubview(downloadButton)
        buttonStackView.addArrangedSubview(bookmarkButton)
        
        view.addSubview(buttonStackView)
    }
    
    func layout() {
        
        NSLayoutConstraint.activate([
            artworkImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            artworkImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            artworkImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            artworkImage.heightAnchor.constraint(equalToConstant: view.frame.width),
            
            techLabel.topAnchor.constraint(equalTo: artworkImage.bottomAnchor, constant: 8),
            techLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            techLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: techLabel.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentInfoStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            contentInfoStack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentInfoStack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            buttonStackView.topAnchor.constraint(equalTo: contentInfoStack.bottomAnchor, constant: 8),
            buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            buttonStackView.trailingAnchor.constraint(equalTo: view.centerXAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: buttonStackView.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            authorLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            authorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            authorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

