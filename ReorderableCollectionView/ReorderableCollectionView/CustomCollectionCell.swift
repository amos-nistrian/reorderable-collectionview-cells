//
//  CustomCollectionCell.swift
//  ReorderableCollectionView
//
//  Created by Amos on 4/4/18.
//  Copyright © 2018 Amos. All rights reserved.
//

import UIKit

class CustomCollectionCell: UICollectionViewCell {
    let label: UILabel = {
        let l = UILabel()
        l.font = UIFont.boldSystemFont(ofSize: 16)
        l.textColor = .black
        l.textAlignment = .center
        l.backgroundColor = .cyan
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        label.anchor(top: topAnchor, left: nil, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 70, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
