//
//  ContentCell.swift
//  Wenderlich Interview Demo
//
//  Created by Koty Stannard on 1/19/22.
//

import UIKit

class ContentCell: UITableViewCell {
    
    struct ViewModel {
        let name: String
        let description: String
        let techStack: String
        let access: String
        let date: String
        let duration: String
        let artworkUrl: URL
    }
    
    let viewModel: ViewModel? = nil
    
    let contentDetailView = ContentDetailView()
    
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

extension ContentCell {
    
    func setup() {
        contentDetailView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(contentDetailView)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 12
        backgroundColor = Colors.appColor
    }
    
    func layout() {
        NSLayoutConstraint.activate([
            contentDetailView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            contentDetailView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            contentDetailView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            contentDetailView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    func configure(with viewModel: ViewModel) {
        contentDetailView.titleLabel.text = viewModel.name
        contentDetailView.techLabel.text = viewModel.techStack
        contentDetailView.descriptionLabel.text = viewModel.description
        contentDetailView.accessLabel.text = viewModel.access
        contentDetailView.dateLabel.text = "\(viewModel.date)"
        contentDetailView.durationLabel.text = viewModel.duration
        
        contentDetailView.artworkImageView.downloadImage(from: viewModel.artworkUrl)
    }
}
