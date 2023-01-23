//
//  FocusViewController.swift
//  HeadSpaceFocus
//
//  Created by 신희권 on 2023/01/23.
//

import UIKit

class FocusViewController: UIViewController {
    
    
    
    @IBOutlet var collectionView: UICollectionView!
    var items: [Focus] = Focus.list
    typealias Item = Focus
    enum Section {
        case main
    }
    var dataSource : UICollectionViewDiffableDataSource<Section,Item>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = UICollectionViewDiffableDataSource<Section,Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FocusCell", for: indexPath) as? FocusCell else {
                return UICollectionViewCell()
            }
            cell.configure(item)
            return cell
            
        })
        var snapshot = NSDiffableDataSourceSnapshot<Section,Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items,toSection: .main)
        dataSource.apply(snapshot)
        
        collectionView.collectionViewLayout = layout()
    }
    private func layout() -> UICollectionViewCompositionalLayout{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50))
        let item = NSCollectionLayoutItem(layoutSize:itemSize )
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        section.interGroupSpacing = 10
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    
    
}
