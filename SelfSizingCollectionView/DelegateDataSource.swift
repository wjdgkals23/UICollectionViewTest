//
//  DelegateDataSource.swift
//  SelfSizingCollectionView
//
//  Created by 정하민 on 2020/10/22.
//

import UIKit

class CustomCollectionViewDelegate: NSObject, UICollectionViewDelegate {
    
}

class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)

        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        attributes?.forEach { layoutAttribute in
            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }

            layoutAttribute.frame.origin.x = leftMargin

            leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
            maxY = max(layoutAttribute.frame.maxY , maxY)
        }

        return attributes
    }
}

class CustomCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    var items: [String] = []
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CustomCollectionViewCell.self), for: indexPath) as? CustomCollectionViewCell
        cell?.title = items[indexPath.row]
        return cell!
    }
}

class CustomCollectionViewDelegateFlowLayout: NSObject, UICollectionViewDelegateFlowLayout {
    
    // 어떻게 움직이나??
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cell = collectionView.dataSource?.collectionView(collectionView, cellForItemAt: indexPath) as? CustomCollectionViewCell
        
        return cell?.contentSize ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
}

class CustomCollectionViewCell: UICollectionViewCell {
    var button = UIButton()
    var contentSize: CGSize {
        return button.frame.size
    }
    
    var title = String() {
        didSet {
            button.setTitle(title, for: .normal)
            setNeedsLayout()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .red
        
        self.addSubview(button)
        button.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
