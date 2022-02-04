//
//  LibraryDetailViewController.swift
//  Wenderlich Interview Demo
//
//  Created by Koty Stannard on 1/26/22.
//

import UIKit

class LibraryDetailViewController: UIViewController {
    
    var content: Attributes
    
    let detailView = LibraryDetailView()
    let artworkImage = ContentImageView(frame: .zero)
    
    init(content: Attributes) {
        self.content = content
        self.detailView.techLabel.text = content.technologyTripleString
        self.detailView.titleLabel.text = content.name
        self.detailView.dateLabel.text = content.formattedDate
        self.detailView.difficultyLabel.text = content.difficulty?.capitalized
        self.detailView.durationLabel.text = content.formattedDuration
        self.detailView.descriptionLabel.text = content.descriptionPlainText
        self.detailView.authorLabel.text = "Contributors: " + content.contributorString
        
        self.artworkImage.downloadImage(from: content.cardArtworkUrl)
        
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
        view.backgroundColor = Colors.appColor
        navigationItem.largeTitleDisplayMode = .never
        
        artworkImage.translatesAutoresizingMaskIntoConstraints = false
        artworkImage.clipsToBounds = true
        
        detailView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(detailView)
        view.addSubview(artworkImage)
    }

    func layout() {
        
        NSLayoutConstraint.activate([

            artworkImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            artworkImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            artworkImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            artworkImage.heightAnchor.constraint(equalToConstant: view.frame.width),
            
            detailView.topAnchor.constraint(equalTo: artworkImage.bottomAnchor),
            detailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

