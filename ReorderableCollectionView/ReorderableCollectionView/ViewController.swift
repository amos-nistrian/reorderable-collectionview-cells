//
//  ViewController.swift
//  ReorderableCollectionView
//
//  Created by Amos on 4/4/18.
//  Copyright © 2018 Amos. All rights reserved.
//

//
//  SecondViewController.swift
//  Example
//
//  Created by Wojtek on 14/07/2015.
//  Copyright © 2015 NSHint. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var myCollectionView: UICollectionView?
    fileprivate var numbers: [Int] = []
    
    fileprivate var longPressGesture: UILongPressGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        for i in 0...100 {
            numbers.append(i)
        }
        
        myCollectionView = initializeCollectionView(cellClass: CustomCollectionCell.self, reuseIdentifier: "Cell", cellHeight: 165)
        
        
        // for placing the collectionviews on the page
        setupCollectionViews(collectionView: myCollectionView!)
        
        // create a the gester recognizers array for the CollectionViews
        let collectionViewGestures = setGestureRecognizers()
        // add the gestures to the collectionViews
        assignGesturesToViews(gesturesArray: collectionViewGestures, collectionView: myCollectionView!)

    }
    
    func assignGesturesToViews(gesturesArray: [UIGestureRecognizer], collectionView: UICollectionView) {
        
        for i in 0..<gesturesArray.count {
            collectionView.addGestureRecognizer(gesturesArray[i])
        }
    }
    
    
    func setGestureRecognizers() -> [UIGestureRecognizer] {
        
        var gesturesArray = [UIGestureRecognizer]()
        
        let longPress: UILongPressGestureRecognizer = {
            let gesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
            gesture.minimumPressDuration = 1.5;
            return gesture
        }()
        
        gesturesArray.append(longPress)
        
        return gesturesArray
    }
    
    @objc func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        
        switch(gesture.state) {
            
        case UIGestureRecognizerState.began:
            guard let selectedIndexPath = self.myCollectionView?.indexPathForItem(at: gesture.location(in: self.myCollectionView)) else {
                break
            }
            myCollectionView?.beginInteractiveMovementForItem(at: selectedIndexPath)
        case UIGestureRecognizerState.changed:
            myCollectionView?.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
        case UIGestureRecognizerState.ended:
            myCollectionView?.endInteractiveMovement()
        default:
            myCollectionView?.cancelInteractiveMovement()
        }
    }
    
    fileprivate func initializeCollectionView(cellClass: UICollectionViewCell.Type, reuseIdentifier: String, cellHeight: CGFloat) -> UICollectionView {
        
        // setting layout of collectionView
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 10) // cells spacing from collectionView edges
        
        let width = view.frame.width / 5
        layout.itemSize = CGSize(width: width, height: width) // size of each cell
        
        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        
        collectionView.backgroundColor = .gray
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(cellClass, forCellWithReuseIdentifier: reuseIdentifier)
        
        return collectionView
        
        
    }
    
    
    fileprivate func setupCollectionViews(collectionView: UICollectionView) {
        
        view.addSubview(collectionView)
        collectionView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 50, paddingLeft: 20, paddingBottom: 20, paddingRight: 20, width: 0, height: 0)
    }
    
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numbers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CustomCollectionCell
        cell.label.text = "\(numbers[indexPath.item])"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let temp = numbers.remove(at: sourceIndexPath.item)
        numbers.insert(temp, at: destinationIndexPath.item)
    }
    
}


