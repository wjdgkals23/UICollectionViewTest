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
            collectionView?.layoutIfNeeded()
            heihgtConstraints?.update(offset: collectionView?.contentSize.height ?? 0)
        }
    }
    var collectionView: UICollectionView?
    var dataSource: CustomCollectionViewDataSource?
    var delegateFlowLayout: CustomCollectionViewDelegateFlowLayout?
    var heihgtConstraints: Constraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let flowLayout = LeftAlignedCollectionViewFlowLayout()
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
            $0.top.leading.trailing.equalToSuperview()
            heihgtConstraints = $0.height.greaterThanOrEqualTo(200).constraint
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
            $0.top.trailing.leading.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        collectionView.items = ["temp", "tt", "tot", "temp", "tt", "tot", "temp", "tt", "tot", "temp", "tt", "tot", "aaaaaaaaa", "bbbbbbbbbbb"]
        
        collectionView.items = ["temp", "tt", "tot", "temp", "tt", "tot", "temp", "tt", "tot", "temp", "tt", "tot", "aaaaaaaaa", "bbbbbbbbbbb", "bbbbbbbbbbb"]
    }

}

