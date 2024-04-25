//
//  AstronomyDescriptionViewController.swift
//  University_Assignment
//
//  Created by Bing Bing on 2024/4/20.
//

import Foundation
import UIKit

enum AstronomyDescriptionSection {
    case date
    case wallpaper
    case title
    case copyright
    case description
}

struct AstronomyDescriptionViewControllerState {
    var sections: [AstronomyDescriptionSection] = []
    var data: Astronomy
}

final class AstronomyDescriptionViewController: ViewController {
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: listLayout())
        collectionView.dataSource = self
        collectionView.register(AstronomyDescriptionImageCell.self, forCellWithReuseIdentifier: AstronomyDescriptionImageCell.reuseID)
        collectionView.register(AstronomyDescriptionTextCell.self, forCellWithReuseIdentifier: AstronomyDescriptionTextCell.reuseID)
        return collectionView
    }()
    
    private let context: AstronomyContext
    private var state: AstronomyDescriptionViewControllerState!
    
    init(context: AstronomyContext, astronomy: Astronomy) {
        self.context = context
        
        super.init(nibName: nil, bundle: nil)
        
        state = AstronomyDescriptionViewControllerState(
            sections: [.date, .wallpaper, .title, .copyright, .description],
            data: astronomy
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

extension AstronomyDescriptionViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return state.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let section = state.sections[indexPath.section]
        
        switch section {
        case .date:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AstronomyDescriptionTextCell.reuseID, for: indexPath) as! AstronomyDescriptionTextCell
            cell.populate(text: state.data.date, alignment: .center)
            return cell
        case .wallpaper:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AstronomyDescriptionImageCell.reuseID, for: indexPath) as! AstronomyDescriptionImageCell
            cell.populate(context: context, url: state.data.url, inset: UIEdgeInsets(h: 20, v: 12))
            
            return cell
        case .title:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AstronomyDescriptionTextCell.reuseID, for: indexPath) as! AstronomyDescriptionTextCell
            cell.populate(text: state.data.title, alignment: .center, inset: UIEdgeInsets(bottom: 12))
            return cell
        case .copyright:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AstronomyDescriptionTextCell.reuseID, for: indexPath) as! AstronomyDescriptionTextCell
            cell.populate(text: "Credit & Copyright: " + state.data.copyright, alignment: .center, inset: UIEdgeInsets(bottom: 12))
            return cell
        case .description:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AstronomyDescriptionTextCell.reuseID, for: indexPath) as! AstronomyDescriptionTextCell
            cell.populate(text: state.data.description, alignment: .natural, inset: UIEdgeInsets(h: 20))
            return cell
        }
    }
}
