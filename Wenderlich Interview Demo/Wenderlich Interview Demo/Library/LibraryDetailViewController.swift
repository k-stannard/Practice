//
//  LibraryDetailViewController.swift
//  Wenderlich Interview Demo
//
//  Created by Koty Stannard on 1/26/22.
//

import UIKit

class LibraryDetailViewController: UIViewController {
    
    var articleName: String!
    
    init(articleName: String) {
        super.init(nibName: nil, bundle: nil)
        self.articleName = articleName
        title = articleName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemRed
    }
}
