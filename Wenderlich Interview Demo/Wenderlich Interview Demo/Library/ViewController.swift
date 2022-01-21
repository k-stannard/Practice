//
//  ViewController.swift
//  Wenderlich Interview Demo
//
//  Created by Koty Stannard on 1/18/22.
//

import UIKit

class ViewController: UIViewController {
    
    let articles: [Article] = [
        Article(name: "raywenderlich.com Learn At Home Sale FAQ", description: "The answers to your questions about the raywenderlich.com Learn At Home Sale!", content_type: "article"),
        Article(name: "Announcing Our Learn At Home Sale!", description: "Save big with limited-time Advanced iOS and Android book bundles, plus 50% off every book in our store!", content_type: "article"),
        Article(name: "Scoped Storage in Android 10: Getting Started", description: "In this tutorial, you’ll learn how to use scoped storage in your Android 10 app by building a simple image gallery.", content_type: "article")
    ]
    
    var articleViewModels = [ArticleCell.ViewModel]()
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
        
        articleViewModels = articles.map {
            ArticleCell.ViewModel(name: $0.name, description: $0.description, contentType: $0.content_type)
        }
        tableView.reloadData()
    }
}

extension ViewController {
    func setup() {
        configureTableView()
    }
    
    func configureTableView() {
        tableView.register(ArticleCell.self, forCellReuseIdentifier: ArticleCell.reuseid)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = ArticleCell.rowHeight
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let article = articleViewModels[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ArticleCell.reuseid, for: indexPath) as! ArticleCell
        cell.configure(with: article)
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

//TODO: - Plug in when network call is created
extension ViewController {
    
//    func configureTableCells(with articles: [Article]) {
//        articleViewModels = articles.map {
//            ArticleCell.ViewModel(name: $0.name, description: $0.description, contentType: $0.content_type)
//        }
//    }
}
