//
//  DetailViewController.swift
//  HWS CoreData
//
//  Created by Koty Stannard on 8/8/22.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    let webView = WKWebView()
    
    var detailItem: Commit?
    
    override func loadView() {
        self.view = webView
        configureURL()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    func configureURL() {
        let urlString = detailItem?.url ?? ""
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}
