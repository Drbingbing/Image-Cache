//
//  CollectionViewLayouts.swift
//  University_Assignment
//
//  Created by Bing Bing on 2024/4/20.
//

import Foundation
import UIKit

func insetGridLayout(count: Int, spacing: CGFloat = 0, inset: UIEdgeInsets = .zero) -> UICollectionViewLayout {
    let columns = 1 / CGFloat(count)
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(columns),
                                         heightDimension: .fractionalHeight(1.0))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    item.contentInsets = .init(top: inset.top, leading: inset.left, bottom: inset.bottom, trailing: inset.right)

    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                           heightDimension: .fractionalWidth(columns))
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                     subitems: [item])
    group.interItemSpacing = .flexible(spacing)

    let section = NSCollectionLayoutSection(group: group)

    let layout = UICollectionViewCompositionalLayout(section: section)
    return layout
}

func listLayout(spacing: CGFloat = 0) -> UICollectionViewLayout {
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(44))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    group.interItemSpacing = .flexible(spacing)
    let section = NSCollectionLayoutSection(group: group)
    return UICollectionViewCompositionalLayout(section: section)
}
