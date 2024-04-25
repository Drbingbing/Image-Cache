//
//  AstronomyDescriptionTextCell.swift
//  University_Assignment
//
//  Created by Bing Bing on 2024/4/20.
//

import Foundation
import UIKit

struct AstronomyDescriptionTextCellState {
    var text: String
    var alignment: NSTextAlignment
    var inset: UIEdgeInsets = .zero
}

final class AstronomyDescriptionTextCell: UICollectionViewCell {
    
    static let reuseID = "AstronomyDescriptionTextCell"
    
    private let label = UILabel()
    
    private var state: AstronomyDescriptionTextCellState? {
        didSet {
            guard let state else { return }
            label.text = state.text
            label.textAlignment = state.alignment
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(label)
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds.inset(by: state?.inset ?? .zero)
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        let size = label.sizeThatFits(targetSize.inset(by: state?.inset ?? .zero))
        return CGSize(width: targetSize.width, height: size.height + (state?.inset.vertical ?? 0))
    }
    
    func populate(text: String, alignment: NSTextAlignment, inset: UIEdgeInsets = .zero) {
        state = AstronomyDescriptionTextCellState(text: text, alignment: alignment, inset: inset)
    }
}
