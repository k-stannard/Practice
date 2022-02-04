//
//  ViewController.swift
//  Wenderlich Interview Demo
//
//  Created by Koty Stannard on 1/18/22.
//

import UIKit

class LibraryViewController: UIViewController {
    
    var content: Content?
    var articleAttributes = [Attributes]()
    var videoAttributes = [Attributes]()
    var attributes = [Attributes]()
    
    var selectedAttribute: AttributeType = .both
    
    var contentViewModels = [ContentCell.ViewModel]()
    
    let tableView = UITableView()
    let segmentedControl = UISegmentedControl(items: ["Both", "Articles", "Videos"])
    let stackView = UIStackView()
    
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
        configureSegmentedControl()
        configureStackView()
        title = "Library"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = Colors.appColor
    }
    
    func configureTableView() {
        tableView.register(ContentCell.self, forCellReuseIdentifier: ContentCell.reuseid)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = ContentCell.rowHeight
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = Colors.appColor
    }
    
    func configureSegmentedControl() {
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(handleSegmentChange), for: .valueChanged)
    }
    
    func configureStackView() {
        let paddedStackView = UIStackView(arrangedSubviews: [segmentedControl])
        paddedStackView.layoutMargins = .init(top: 12, left: 12, bottom: 12, right: 12)
        paddedStackView.isLayoutMarginsRelativeArrangement = true
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 8
        stackView.axis = .vertical
        
        stackView.addArrangedSubview(paddedStackView)
        stackView.addArrangedSubview(tableView)
        
        view.addSubview(stackView)
    }
    
    func layout() {
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

//MARK: - Actions
extension LibraryViewController {
    
    @objc func handleSegmentChange() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            selectedAttribute = .both
            DispatchQueue.main.async { self.reloadView() }
        case 1:
            selectedAttribute = .article
            DispatchQueue.main.async { self.reloadView() }
        case 2:
            selectedAttribute = .video
            DispatchQueue.main.async { self.reloadView() }
        default:
            break
        }
    }
}

//MARK: - Table View DataSource Methods
extension LibraryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attributes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let content = contentViewModels[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ContentCell.reuseid, for: indexPath) as! ContentCell
        cell.configure(with: content)
        return cell
    }
}

//MARK: - Table View Delegate Methods
extension LibraryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let content = attributes[indexPath.row]
        let destination = LibraryDetailViewController(content: content)
        navigationController?.pushViewController(destination, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//TODO: - Data Fetching & Configuration
extension LibraryViewController {
    
    func fetchData() {
        let group = DispatchGroup()
        
        fetchVideoContent(group: group)
        fetchArticleContent(group: group)
        
        group.notify(queue: .main) {
            self.reloadView()
        }
    }
    
    func fetchArticleContent(group: DispatchGroup) {
        group.enter()
        NetworkManager.shared.fetchContent(url: Url.articleUrl) { result in
            switch result {
            case .success(let articles):
                articles.forEach { article in
                    self.articleAttributes.append(article.attributes)
                }
            case .failure(let error):
                print(error)
            }
            group.leave()
        }
    }
    
    func fetchVideoContent(group: DispatchGroup) {
        group.enter()
        NetworkManager.shared.fetchContent(url: Url.videoUrl) { result in
            switch result {
            case .success(let videos):
                videos.forEach { video in
                    self.videoAttributes.append(video.attributes)
                }
            case .failure(let error):
                print(error)
            }
            group.leave()
        }
    }
    
    func reloadView() {
        var attributes = [Attributes]()
        
        switch selectedAttribute {
        case .article:
            attributes = articleAttributes
        case .video:
            attributes = videoAttributes
        case .both:
            attributes = articleAttributes + videoAttributes
        }
        
        self.attributes = attributes
        
        self.attributes.sort { content1, content2 in
            content1.releasedAt > content2.releasedAt
        }
        self.configureTableCells(with: self.attributes)
        self.tableView.reloadData()
    }
    
    func configureTableCells(with attributes: [Attributes]) {
        
        contentViewModels = attributes.map {
            return ContentCell.ViewModel(name: $0.name, description: $0.descriptionPlainText, techStack: $0.technologyTripleString, access: $0.accessLevel, date: $0.formattedDate, duration: $0.formattedDuration, artworkUrl: $0.cardArtworkUrl)
        }
    }
}
