//
//  PostView.swift
//  Instaclone
//
//  Created by Koty Stannard on 6/7/22.
//

import UIKit

class PostView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 200)
    }
}

extension PostView {
    
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .blue
    }
    
    func layout() {
        
    }
}
