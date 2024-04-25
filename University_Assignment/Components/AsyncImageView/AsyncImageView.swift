//
//  AsyncImageView.swift
//  University_Assignment
//
//  Created by Bing Bing on 2024/4/20.
//

import Foundation
import UIKit

final class AsyncImageView: UIView {
    
    private let imageView = UIImageView()
    private let indicator = UIActivityIndicatorView(style: .medium)
    private let skelentonLayer = CAGradientLayer()
    
    override var intrinsicContentSize: CGSize {
        return imageView.intrinsicContentSize
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.addSublayer(skelentonLayer)
        addSubview(imageView)
        skelentonLayer.colors = UIColor(0xecf0f1).makeGradient()
        skelentonLayer.startPoint = CGPoint(x: 0, y: 0.5)
        skelentonLayer.endPoint = CGPoint(x: 1, y: 0.5)
        skelentonLayer.anchorPoint = .zero
        
        DispatchQueue.main.async { CATransaction.begin() }
        animate()
        DispatchQueue.main.async { CATransaction.commit() }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds
        skelentonLayer.frame = bounds
        animate()
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        imageView.sizeThatFits(size)
    }
    
    func setImageURL(context: AstronomyContext, url: String, completion: ((UIImage?) -> Void)? = nil) {
        
        imageView.image = nil
        context.image.setImageURL(url) { [weak self] image in
            self?.removeAnimation()
            self?.imageView.image = image
            completion?(image)
        }
    }
    
    func setImage(_ image: UIImage?) {
        imageView.image = image
        removeAnimation()
    }
    
    func animate() {
        let startPointAnim = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.startPoint))
        startPointAnim.fromValue = CGPoint(x: -1, y: -1)
        startPointAnim.toValue = CGPoint(x: 1, y: 1)
        
        let endPointAnim = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.endPoint))
        endPointAnim.fromValue = CGPoint(x: 0, y: 0)
        endPointAnim.toValue = CGPoint(x: 2, y: 2)
        
        let animGroup = CAAnimationGroup()
        animGroup.animations = [startPointAnim, endPointAnim]
        animGroup.duration = 1.5
        animGroup.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        animGroup.autoreverses = false
        animGroup.repeatCount = .infinity
        animGroup.isRemovedOnCompletion = false
        
        skelentonLayer.add(animGroup, forKey: "skeletonAnimation")
    }
    
    func removeAnimation() {
        skelentonLayer.removeAnimation(forKey: "skeletonAnimation")
    }
}
