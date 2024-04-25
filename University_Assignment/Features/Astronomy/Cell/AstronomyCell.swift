//
//  AstronomyCell.swift
//  University_Assignment
//
//  Created by Bing Bing on 2024/4/20.
//

import Foundation
import UIKit

struct AstronomyCellState {
    var astronomy: Astronomy
}

final class AstronomyCell: UICollectionViewCell {
    
    static let reuseID = "AstronomyCell"
    
    private let titleLabel = UILabel()
    private let imageView = AsyncImageView()
    
    private var context: AstronomyContext?
    private var state: AstronomyCellState? {
        didSet {
            guard let state else { return }
            titleLabel.textColor = .black
            titleLabel.text = state.astronomy.title
            imageView.setImageURL(context: context!, url: state.astronomy.url) { [weak self] _ in
                self?.titleLabel.textColor = .white
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        
        titleLabel.font = .systemFont(ofSize: 18)
        titleLabel.numberOfLines = 3
        titleLabel.textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.frame = bounds.inset(by: UIEdgeInsets(h: 6, v: 4))
        imageView.frame = bounds
    }
    
    func populate(context: AstronomyContext, astronomy: Astronomy) {
        self.context = context
        self.state = AstronomyCellState(astronomy: astronomy)
    }
}
