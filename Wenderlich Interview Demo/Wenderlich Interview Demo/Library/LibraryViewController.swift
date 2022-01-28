//
//  ViewController.swift
//  Wenderlich Interview Demo
//
//  Created by Koty Stannard on 1/18/22.
//

import UIKit

class LibraryViewController: UIViewController {
    
    var content: Content?
    var articles = [Article]()
    
    var articleViewModels = [ArticleCell.ViewModel]()
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
        fetchData()
    }
}

//MARK: - View Controller Setup & Layout
extension LibraryViewController {
    func setup() {
        configureTableView()
        title = "Library"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureTableView() {
        tableView.register(ArticleCell.self, forCellReuseIdentifier: ArticleCell.reuseid)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = ArticleCell.rowHeight
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.init(red: 217/255, green: 242/255, blue: 255/255, alpha: 1)
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

//MARK: - Table View DataSource Methods
extension LibraryViewController: UITableViewDataSource {
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

//MARK: - Table View Delegate Methods
extension LibraryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = articles[indexPath.row]
        let destination = LibraryDetailViewController(article: article)
        navigationController?.pushViewController(destination, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//TODO: - Data Fetching & Configuration
extension LibraryViewController {
    
    func fetchData() {
        fetchArticles { [unowned self] result in
            switch result {
            case .success(let articles):
                articles.forEach { item in
                    self.articles.append(item.attributes)
                }
                self.configureTableCells(with: self.articles)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func configureTableCells(with articles: [Article]) {
        lazy var accessLevel: String = ""
        
        articleViewModels = articles.map {
            accessLevel = $0.free == true ? "" : "Pro"
            let tuple = minutesToHoursAndMinutes($0.duration)
            let date = format($0.releasedAt)
            return ArticleCell.ViewModel(name: $0.name, description: $0.descriptionPlainText, techStack: $0.technologyTripleString, access: accessLevel, date: date, length: "\(tuple.hours) hrs, \(tuple.leftMinutes) mins")
        }
    }
}

//MARK: - Date & Time Formatting
extension LibraryViewController {
    
    func minutesToHoursAndMinutes(_ minutes: Int) -> (hours: Int, leftMinutes: Int) {
        return (minutes / 60, (minutes % 60))
    }
    
    func format(_ date: String) -> String {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withFullDate, .withDashSeparatorInDate, .withFractionalSeconds]
        let isoDate = isoFormatter.date(from: date)
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "MMM d yyyy"
        
        return dateFormatter.string(from: isoDate!)
    }
}
