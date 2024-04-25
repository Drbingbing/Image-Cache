//
//  AstronomyDescriptionImageCell.swift
//  University_Assignment
//
//  Created by Bing Bing on 2024/4/20.
//

import Foundation
import UIKit

struct AstronomyDescriptionImageCellState {
    var url: String
    var inset: UIEdgeInsets = .zero
}

final class AstronomyDescriptionImageCell: UICollectionViewCell {
    
    static let reuseID = "AstronomyDescriptionImageCell"
    
    private let imageView = AsyncImageView()
    
    private var context: AstronomyContext?
    private var state: AstronomyDescriptionImageCellState? {
        didSet {
            guard let state, let context else { return }
            imageView.setImageURL(context: context, url: state.url)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds.inset(by: state?.inset ?? .zero)
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        return CGSize(width: targetSize.width, height: 250 + (state?.inset.vertical ?? 0))
    }
    
    func populate(context: AstronomyContext, url: String, inset: UIEdgeInsets = .zero) {
        self.context = context
        self.state = AstronomyDescriptionImageCellState(url: url, inset: inset)
    }
}
