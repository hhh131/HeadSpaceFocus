//
//  FocusViewController.swift
//  HeadSpaceFocus
//
//  Created by 신희권 on 2023/01/23.
//

import UIKit

class FocusViewController: UIViewController {
    
    
    
    @IBOutlet var refreshBtn: UIButton!
    @IBOutlet var collectionView: UICollectionView!
    var items: [Focus] = Focus.list
    typealias Item = Focus
    enum Section {
        case main
    }
    var dataSource : UICollectionViewDiffableDataSource<Section,Item>!
    var curated : Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshBtn.layer.cornerRadius = 10
        dataSource = UICollectionViewDiffableDataSource<Section,Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FocusCell", for: indexPath) as? FocusCell else {
                return UICollectionViewCell()
            }
            cell.configure(item)
            return cell
            
        })
        dataSourceApply()
        collectionView.collectionViewLayout = layout()
        upadateButtonTitle()
       
      
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
    
    func upadateButtonTitle(){
        let title = curated ? "Sea All" : "recommendation"
        refreshBtn.setTitle(title, for: .normal)
    }
    func dataSourceApply(){
        var snapshot = NSDiffableDataSourceSnapshot<Section,Item>()
        
        snapshot.appendSections([.main])
        snapshot.appendItems(items,toSection: .main)
        dataSource.apply(snapshot)
    }
    
    @IBAction func refreshBtnTapped(_ sender: Any) {
        curated.toggle()
        self.items = curated ? Focus.recommendations : Focus.list
        dataSourceApply()
     
        upadateButtonTitle()
  
    }
    
    
    
}
