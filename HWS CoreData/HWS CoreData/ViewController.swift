//
//  ViewController.swift
//  HWS CoreData
//
//  Created by Koty Stannard on 8/7/22.
//

import UIKit
import CoreData
import SwiftyJSON

class ViewController: UIViewController, NSFetchedResultsControllerDelegate {
    
    var container: NSPersistentContainer!
    var fetchedResultsController: NSFetchedResultsController<Commit>!
    var commitPredicate: NSPredicate?
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Swift Git Commits"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(changeFilter))
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        tableView.fillSuperview()
        
        configureCoreData()
        
        performSelector(inBackground: #selector(fetchCommits), with: nil)
        loadSavedData()
    }
    
    @objc func changeFilter() {
        let alert = UIAlertController(title: "Filter commits...", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Show only fixes", style: .default) { [unowned self] _ in
            self.commitPredicate = NSPredicate(format: "message CONTAINS[c] 'fix'")
            self.loadSavedData()
        })
        
        alert.addAction(UIAlertAction(title: "Ignore Pull Requests", style: .default) { [unowned self] _ in
            self.commitPredicate = NSPredicate(format: "NOT message BEGINSWITH 'Merge pull request'")
            self.loadSavedData()
        })
        
        alert.addAction(UIAlertAction(title: "Show only recent", style: .default) { [unowned self] _ in
            let twelveHoursAgo = Date().addingTimeInterval(-43200)
            self.commitPredicate = NSPredicate(format: "date > %@", twelveHoursAgo as NSDate)
            self.loadSavedData()
        })
        
        alert.addAction(UIAlertAction(title: "Show only Durian commits", style: .default) { [unowned self] _ in
            self.commitPredicate = NSPredicate(format: "author.name == 'Joe Groff'")
            self.loadSavedData()
        })
        
        alert.addAction(UIAlertAction(title: "Show all commits", style: .default) { [unowned self] _ in
            self.commitPredicate = nil
            self.loadSavedData()
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
    
    func loadSavedData() {
        if fetchedResultsController == nil {
            // Create request and give it a sort descriptor
            let request = Commit.createFetchRequest()
            let sort = NSSortDescriptor(key: "author.name", ascending: true)
            request.sortDescriptors = [sort]
            request.fetchBatchSize = 20
            
            fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: container.viewContext, sectionNameKeyPath: "author.name", cacheName: nil)
            fetchedResultsController.delegate = self
        }
        
        fetchedResultsController.fetchRequest.predicate = commitPredicate
        
        // Fetch the saved objects & insert into the array of commits
        // Reload table to view data
        do {
            try fetchedResultsController.performFetch()
            tableView.reloadData()
        } catch {
            print("Fetch failed")
        }
    }
    
    // JSON Parsing method
    func configure(commit: Commit, usingJson json: JSON) {
        commit.sha = json["sha"].stringValue
        commit.message = json["commit"]["message"].stringValue
        commit.url = json["html_url"].stringValue
        
        let formatter = ISO8601DateFormatter()
        commit.date = formatter.date(from: json["commit"]["committer"]["date"].stringValue) ?? Date()
        
        var commitAuthor: Author!
        
        let authorRequest = Author.createFetchRequest()
        authorRequest.predicate = NSPredicate(format: "name == %@", json["commit"]["committer"]["name"].stringValue)
        
        if let authors = try? container.viewContext.fetch(authorRequest) {
            if authors.count > 0 {
                commitAuthor = authors[0]
            }
        }
        
        if commitAuthor == nil {
            let author = Author(context: container.viewContext)
            author.name = json["commit"]["committer"]["name"].stringValue
            author.email = json["commit"]["committer"]["email"].stringValue
            commitAuthor = author
        }
        
        commit.author = commitAuthor
    }
    
    func getNewestCommitDate() -> String {
        let formatter = ISO8601DateFormatter()
        
        let newest = Commit.createFetchRequest()
        let sort = NSSortDescriptor(key: "date", ascending: false)
        newest.sortDescriptors = [sort]
        newest.fetchLimit = 1
        
        if let commits = try? container.viewContext.fetch(newest) {
            if commits.count > 0 {
                return formatter.string(from: commits[0].date.addingTimeInterval(1))
            }
        }
        
        return formatter.string(from: Date(timeIntervalSince1970: 0))
    }
    
    @objc func fetchCommits() {
        let newestCommitDate = getNewestCommitDate()
        
        if let data = try? String(contentsOf: URL(string: "https://api.github.com/repos/apple/swift/commits?per_page=100&since=\(newestCommitDate)")!) {
            let jsonCommits = JSON(parseJSON: data)
            
            let jsonCommitsArray = jsonCommits.arrayValue
            
            print("Received \(jsonCommitsArray.count) new commits.")
            
            DispatchQueue.main.async { [unowned self] in
                for jsonCommit in jsonCommitsArray {
                    
                    // Creates a commit object inside managed object context
                    let commit = Commit(context: self.container.viewContext)
                    
                    // Pass object data to the matching commit
                    self.configure(commit: commit, usingJson: jsonCommit)
                }
                
                self.saveContext()
                self.loadSavedData()
            }
        }
    }

    func configureCoreData() {
        // Create persistent container
        container = NSPersistentContainer(name: "GHData")
        
        // Load the saved database if exists, otherwise create it
        container.loadPersistentStores { storeDescription, error in
            self.container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            
            if let error = error {
                print("Unresolved error \(error)")
            }
        }
    }
    
    // Method that saves changes from memory to disk
    func saveContext() {
        if container.viewContext.hasChanges {
            do {
                try container.viewContext.save()
            } catch {
                print("An error occurred while saving: \(error)")
            }
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .automatic)
        default:
            break
        }
    }
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        fetchedResultsController.sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.accessoryType = .disclosureIndicator
        tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let commit = fetchedResultsController.object(at: indexPath)
        cell.textLabel!.text = commit.message
        cell.detailTextLabel!.text = "By \(commit.author.name) on \(commit.date.description)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let commit = fetchedResultsController.object(at: indexPath)
            container.viewContext.delete(commit)
            saveContext()
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        fetchedResultsController.sections![section].name
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        detailViewController.detailItem = fetchedResultsController.object(at: indexPath)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
