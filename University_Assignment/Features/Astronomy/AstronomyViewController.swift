//
//  AstronomyViewController.swift
//  University_Assignment
//
//  Created by Bing Bing on 2024/4/20.
//

import Foundation
import UIKit

struct AstronomyViewControllerState {
    var data: [Astronomy] = []
}

struct AstronomyViewControllerActions {
    var didSelectedItemAt: (IndexPath) -> Void
}

final class AstronomyViewController: ViewController {
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero, 
            collectionViewLayout: insetGridLayout(count: 4, spacing: 2, inset: UIEdgeInsets(bottom: 2))
        )
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(AstronomyCell.self, forCellWithReuseIdentifier: AstronomyCell.reuseID)
        return collectionView
    }()
    
    private let context: AstronomyContext
    private var state: AstronomyViewControllerState!
    private var actions: AstronomyViewControllerActions?
    
    init(context: AstronomyContext, astronomy: [Astronomy]) {
        self.context = context
        
        super.init(nibName: nil, bundle: nil)
        
        state = AstronomyViewControllerState(data: astronomy)
        actions = AstronomyViewControllerActions(
            didSelectedItemAt: { [weak self] indexPath in
                guard let self else { return }
                let item = self.state.data[indexPath.item]
                let vc = AstronomyDescriptionViewController(context: context, astronomy: item)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds.inset(by: view.safeAreaInsets)
    }
}


extension AstronomyViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return state.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AstronomyCell.reuseID, for: indexPath) as! AstronomyCell
        let atronomy = state.data[indexPath.item]
        cell.populate(context: context, astronomy: atronomy)
        return cell
    }
}

extension AstronomyViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        actions?.didSelectedItemAt(indexPath)
    }
}
