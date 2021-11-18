//
//  AnimatedCollectionView.swift
//  CandiBustApp
//
//  Created by Jageloo Yadav on 18/11/21.
//

import Foundation
import UIKit

class AnimatedCollectionView: UICollectionView {
    var isAnimated = false
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10.0
        super.init(frame: .zero, collectionViewLayout: layout)
        self.delegate = self
        self.dataSource = self
        self.register(PageCell.self, forCellWithReuseIdentifier: "PageCell")
        self.transform = CGAffineTransform.init(scaleX: 1, y: -1)
    }
    
    func reload(isAnimated: Bool) {
        self.isAnimated = isAnimated
        self.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AnimatedCollectionView: UICollectionViewDelegate {
    
}

extension AnimatedCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PageCell", for: indexPath) as? PageCell else {
            fatalError("Unable to load cell")
        }
        if indexPath.row == 0 || indexPath.row == 1 {
            cell.animateFromRight()
        }
        return cell
    }
}

private class PageCell: UICollectionViewCell {
    var isAnimated = false
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animateFromRight() {
        let position = self.center
        let fromPosition = CGPoint.init(x: position.x + self.frame.width/2, y: position.y)
        self.center = fromPosition
        self.alpha = 0.0
        UIView.animate(withDuration: 1.0) {
            self.alpha = 1.0
            self.center = position
        }
    }
    
    private func setup() {
        let grey = UIView()
        grey.backgroundColor = .gray
        self.addSubview(grey)
        grey.anchorToSuperView()
    }
}

extension AnimatedCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        return CGSize.init(width: width/2, height: collectionView.frame.height)
    }
}
