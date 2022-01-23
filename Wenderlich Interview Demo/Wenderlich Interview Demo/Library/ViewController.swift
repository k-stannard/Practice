//
//  ViewController.swift
//  Wenderlich Interview Demo
//
//  Created by Koty Stannard on 1/18/22.
//

import UIKit

class ViewController: UIViewController {
    
    let articles: [Article] = [
        Article(name: "iOS Test-Driven Development by Tutorials", released_at: Date(), free: false, difficulty: "intermediate", content_type: "edition", duration: 50, technology_triple_string: "Swift 5.5, iOS 15, Xcode 13", contributor_string: "Melanie Demmer, Michael Katz, Joshua Greene & Darren Ferguson", description_plain_text: "Learn How to Test iOS Applications!\nThis book is for intermediate iOS developers who already know the basics of iOS and Swift development but want to learn how to write code which is both testable and maintainable.\nTo start, you’ll learn the TDD Cycle and how to implement these concepts within an iOS application. The book then takes you through Test Expressions and Expectation so that you can test synchronous code. You’ll then write tests to verify networking endpoints and the ability to mock the returned results, followed by writing tests that run against authentication endpoints. Continue trouble-shooting your apps by understanding common legacy problems, as well as breaking dependencies into modules. And, finally, refactor large classes into smaller, more manageable classes and objects.\n", card_artwork_url: URL(string: "www.google.com")!),
        Article(name: "Beginning Flutter Debugging", released_at: Date(), free: false, difficulty: "beginner", content_type: "collection", duration: 50, technology_triple_string: "Dart 2.14, Flutter 2.5, VS Code 1.62 OR Android Studio", contributor_string: "Emmanuel Okiche & Adriana Kutenko", description_plain_text: "Learn the basics of debugging and explore how to resolve common errors that Flutter developers face during app development.\n", card_artwork_url: URL(string: "www.google.com")!),
        Article(name: "Subhrajyoti Sen - Podcast S12 E05", released_at: Date(), free: false, difficulty: "intermediate", content_type: "article", duration: 50, technology_triple_string: "Kotlin 1.5, Android 10.0, Android Studio 2020.3.1", contributor_string: "Dru Freeman", description_plain_text: "Google Development Expert Subhrajyoti Sen is on board with Susannah and Dru to talk about everything from mentoring to publishing Apps on the Play Store to even recognizing Kannada writing with Machine Learning\n", card_artwork_url: URL(string: "www.google.com")!)
    ]
    
    var articleViewModels = [ArticleCell.ViewModel]()
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
        
        articleViewModels = articles.map {
            ArticleCell.ViewModel(name: $0.name, description: $0.description_plain_text, techStack: $0.technology_triple_string, access: "free", date: $0.released_at, length: "12345")
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
