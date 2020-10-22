//
//  ViewController.swift
//  SelfSizingCollectionView
//
//  Created by 정하민 on 2020/10/22.
//

import UIKit
import SnapKit

class CollectionContainer: UIView {
    var items: [String] = [] {
        didSet {
            dataSource?.items = items
            collectionView?.reloadData()
        }
    }
    var collectionView: UICollectionView?
    var dataSource: CustomCollectionViewDataSource?
    var delegateFlowLayout: CustomCollectionViewDelegateFlowLayout?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.estimatedItemSize = .init(width: 200, height: 200)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    
        dataSource = CustomCollectionViewDataSource()
        delegateFlowLayout = CustomCollectionViewDelegateFlowLayout()
        
        collectionView?.collectionViewLayout = flowLayout
        collectionView?.dataSource = dataSource
        collectionView?.delegate = delegateFlowLayout
        collectionView?.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: CustomCollectionViewCell.self))
        
        self.addSubview(collectionView!)
        collectionView?.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let collectionView = CollectionContainer(frame: .zero)
        self.view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        collectionView.items = ["temp", "tt", "tot", "temp", "tt", "tot", "temp", "tt", "tot", "temp", "tt", "tot", "aaaaaaaaa", "bbbbbbbbbbb"]
    }


}

