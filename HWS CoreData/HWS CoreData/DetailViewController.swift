//
//  DetailViewController.swift
//  HWS CoreData
//
//  Created by Koty Stannard on 8/8/22.
//

import UIKit

class DetailViewController: UIViewController {
    
    let detailLabel = UILabel()
    
    var detailItem: Commit?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.numberOfLines = 0
        view.addSubview(detailLabel)
        detailLabel.centerInSuperview(size: .init(width: view.frame.width - 50, height: view.frame.height))
     
        if let detail = self.detailItem {
            detailLabel.text = detail.message
            //navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Commit 1/\(detail.author.commits.count)", style: .plain, target: self, action: #selector(showAuthorCommits))
        }
    }
}
