//
//  GameDetailViewController.swift
//  CandiBustApp
//
//  Created by Jageloo Yadav on 16/11/21.
//

import Foundation
import UIKit

class GameDetailViewController: UIViewController {
    private let viewModel: GameDetailViewModelProtocol
    private let closeButton = UIButton(type: .custom)
    private let iconView = IconView()
    private let button = Button()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let readMoreButton = UIButton()
    private var collectionView = AnimatedCollectionView()
    
    var animationCompleted: (() -> Void)?
    var animationInfo: CellAnimationInfo?
    
    init(viewModel: GameDetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        self.animationCompleted = { [weak self] in
            self?.startAnimations()
        }
    }
        
    @objc func close() {
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK:- Extension GameDetailViewController: Wrapps view components design
extension GameDetailViewController {
    
    private func setup() {
        hideChilds()
        setupCloseButton()
        setupIcon()
        setupButton()
        setupTitleLabel()
        setupDescriptionLabel()
        setupMoreButton()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.anchorToSuperView(topAnchor: readMoreButton.bottomAnchor,
                                      bottomRelation: .ignore,
                                      leading: 0,
                                      trailing: 0,
                                      top: 10)
        collectionView.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -20.0).isActive = true
    }
    
    func setupCloseButton() {
        self.view.backgroundColor = .white
        closeButton.setImage(UIImage(systemName: "multiply"), for: .normal)
        self.view.addSubview(closeButton)
        closeButton.anchorToSuperView(topAnchor: self.view.safeAreaLayoutGuide.topAnchor,
                                      leadingRelation: .ignore,
                                      bottomRelation: .ignore, trailing: 20.0, top: 10.0)
        closeButton.addTarget(self, action: #selector(self.close), for: .touchUpInside)
    }
    
    private func hideChilds() {
        collectionView.alpha = 0.0
        closeButton.alpha = 0.0
        iconView.alpha = 0.0
        button.alpha = 0.0
        titleLabel.alpha = 0.0
        descriptionLabel.alpha = 0.0
        readMoreButton.alpha = 0.0
    }
    private func setupIcon() {
        view.addSubview(iconView)
        iconView.anchorToSuperView(topAnchor: view.safeAreaLayoutGuide.topAnchor,
                                   trailingRelation: .ignore,
                                   bottomRelation: .ignore,
                                   leading: 20, top: 10)
    }
    
    private func setupMoreButton() {
        readMoreButton.setTitle(viewModel.readMoreTitle, for: .normal)
        view.addSubview(readMoreButton)
        readMoreButton.anchorToSuperView(topAnchor: descriptionLabel.bottomAnchor,
                                         trailingRelation: .greaterOrEqual,
                                         bottomRelation: .greaterOrEqual,
                                         leading: 20,
                                         trailing: 20.0,
                                         top: 10)
        readMoreButton.setTitleColor(.green, for: .normal)
        readMoreButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    private func setupButton() {
        view.addSubview(button)
        button.style = .style1
        button.setTitle(viewModel.nextButtonTitle, for: .normal)
        button.anchorToSuperView(bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor,
                                 topRelation: .ignore,
                                 leading: 20,
                                 trailing: 20,
                                 bottom: 20.0)
    }
    
    private func setupTitleLabel() {
        self.view.addSubview(titleLabel)
        titleLabel.text = viewModel.title
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .left
        titleLabel.anchorToSuperView(leadingAnchor: iconView.trailingAnchor,
                                     topAnchor: iconView.topAnchor,
                                     bottomRelation: .ignore,
                                     leading: 10,
                                     top: 0)
    }
    
    private func setupDescriptionLabel() {
        self.view.addSubview(descriptionLabel)
        descriptionLabel.textAlignment = .left
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.text = viewModel.descriptionText
        descriptionLabel.numberOfLines = 0
        descriptionLabel.anchorToSuperView(topAnchor: iconView.bottomAnchor,
                                           bottomRelation: .ignore,
                                           leading: 20,
                                           trailing: 20.0,
                                           top: 10)
    }
    
    private func animateCrossButton() {
        closeButton.transform = CGAffineTransform.init(scaleX: 1.0, y: 0)
        UIView.animate(withDuration: 0.5) {
            self.closeButton.transform = .identity
        }
    }
}

//MARK:- Extension GameDetailViewController: Wrapps animation functions
extension GameDetailViewController {
    private func animateIcon(completion: (() -> Void)?) {
        let toCenter = iconView.center
        let fromCenter = self.animationInfo?.iconAbsolutePosition ?? .zero
        iconView.center = fromCenter
        UIView.animate(withDuration: 0.5) {
            self.iconView.center = toCenter
            self.view.layoutIfNeeded()
        } completion: { _ in
            completion?()
        }
    }
    
    private func animateDescriptionLabel(completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.5) {
            self.descriptionLabel.alpha = 1.0
        } completion: { _ in
            completion?()
        }
    }
    
    private func animateReadMoreButton(completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.5) {
            self.readMoreButton.alpha = 1.0
        } completion: { _ in
            completion?()
        }
    }
    
    private func animateButton() {
        let toCenter = button.center
        let fromCenter = self.animationInfo?.butonAbsolutePosition ?? .zero
        button.center = fromCenter
        if let frame = self.animationInfo?.buttonAbsoluteFrame {
            let buttonOrinalFrame = self.button.frame
            button.transform = CGAffineTransform.init(scaleX: frame.width/buttonOrinalFrame.width, y: 1.0)
        }
        UIView.animate(withDuration: 0.5) {
            self.button.center = toCenter
            self.button.transform = .identity
            self.view.layoutIfNeeded()
        }
    }
    
    private func animateTitle() {
        let toCenter = titleLabel.center
        let fromCenter = self.animationInfo?.titleAbsolutePosition ?? .zero
        titleLabel.center = fromCenter
        if let frame = self.animationInfo?.titleAbsoluteFrame {
            let buttonOrinalFrame = self.titleLabel.frame
            titleLabel.transform = CGAffineTransform.init(scaleX: frame.width/buttonOrinalFrame.width, y: 1.0)
        }
        UIView.animate(withDuration: 0.5) {
            self.titleLabel.center = toCenter
            self.titleLabel.transform = .identity
            self.view.layoutIfNeeded()
        }
    }
    
    func animateCollectionView() {
        UIView.animate(withDuration: 0.5) {
            self.collectionView.alpha = 1.0
            self.collectionView.reload(isAnimated: true)
        }
    }
    
    private func startAnimations() {
        self.closeButton.alpha = 1.0
        self.iconView.alpha = 1.0
        self.button.alpha = 1.0
        self.titleLabel.alpha = 1.0
        self.animateCrossButton()
        self.animateIcon(completion: {
            self.animateDescriptionLabel()
            self.animateReadMoreButton()
            self.animateCollectionView()
        })
        self.animateButton()
        self.animateTitle()
    }
}
