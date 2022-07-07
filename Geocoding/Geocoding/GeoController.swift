//
//  GeoController.swift
//  Geocoding
//
//  Created by Koty Stannard on 7/5/22.
//

import UIKit
import MapKit

class GeoController: UIViewController {
    
    let searchBar = UISearchBar()
    let tableView = UITableView()
    
    var locations = [Location]()
    
    lazy var searchCompleter: MKLocalSearchCompleter = {
        let completer = MKLocalSearchCompleter()
        completer.delegate = self
        return completer
    }()
    
    var searchSource: [String]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        layout()
    }
    
    func configure() {
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        tableView.dataSource = self
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.delegate = self
    }
    
    func layout() {
        view.addSubview(searchBar)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension GeoController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//        let location = self.locations[indexPath.row]
//
//        if location.city == "" {
//            cell.textLabel?.text = "\(location.name), \(location.state), \(location.country)"
//        } else {
//            cell.textLabel?.text = "\(location.city), \(location.state), \(location.country)"
//        }
        cell.textLabel?.text = self.searchSource?[indexPath.row]
        
        return cell
    }
}

extension GeoController: UITableViewDelegate {
    
}

extension GeoController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            searchCompleter.queryFragment = searchText
//            LocationManager.shared.findLocation(with: searchText) { locations in
//                self.searchCompleter.queryFragment = searchText
//                self.locations = locations
//                DispatchQueue.main.async {
//
//                    self.tableView.reloadData()
//                }
//            }
        }
    }
}

extension GeoController: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        LocationManager.shared.findLocation(with: searchCompleter.queryFragment) { locations in
            self.locations = locations
            self.searchSource = self.locations.map { $0.name + $0.state + $0.country }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
//        self.searchSource = completer.results.map { $0.title }
//        DispatchQueue.main.async {
//            self.tableView.reloadData()
//        }
    }

    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
