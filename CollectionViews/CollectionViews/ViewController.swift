//
//  ViewController.swift
//  CollectionViews
//
//  Created by Koty Stannard on 2/7/22.
//

import UIKit

class ViewController: UIViewController {
    
    enum Section { case main }
    
    var collectionView: UICollectionView! = nil
    var dataSource: UICollectionViewDiffableDataSource<Section, Int>! = nil
        
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}

extension ViewController {
    func style() {
        title = "Collection Views"
        navigationController?.navigationBar.prefersLargeTitles = true
        configureCollectionView()
        configureDataSource()
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemTeal
        view.addSubview(collectionView)
    }
    
    func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Int> { (cell, indexPath, identifier) in
            
            var content = cell.defaultContentConfiguration()
            content.text = "\(identifier)"
            content.image = UIImage(systemName: "star")
            cell.contentConfiguration = content
            
            //cell.label.text = "\(identifier)"
//            cell.backgroundColor = .systemRed
//            cell.layer.borderColor = UIColor.black.cgColor
//            cell.layer.borderWidth = 1
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, Int>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapshot.appendSections([.main])
        snapshot.appendItems(Array(0...100))
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    func layout() {
        
//        NSLayoutConstraint.activate([
//
//        ])
    }
}
