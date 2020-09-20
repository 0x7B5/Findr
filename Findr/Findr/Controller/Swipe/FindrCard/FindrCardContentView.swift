//
//  FindrCardContentView.swift
//  Findr
//
//  Created by Vlad Munteanu on 9/20/20.
//

import UIKit
import SDWebImage

class FindrCardContentView: UIView {
    
    private let backgroundView: UIView = {
        let background = UIView()
        background.clipsToBounds = true
        background.layer.cornerRadius = 20
        return background
    }()
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let gradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.black.withAlphaComponent(0.01).cgColor,
                           UIColor.black.withAlphaComponent(0.8).cgColor]
        gradient.startPoint = CGPoint(x: 0.5, y: 0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1)
        return gradient
    }()
    
    init(withImage image: String, isFood: Bool) {
        super.init(frame: .zero)
        
        if isFood {
            imageView.sd_setImage(with: URL(string: image), placeholderImage: UIImage(named: "food"))
            
        } else {
            var substring = image.dropLast(7)
            let newString = String(substring) + "342.jpg"
            imageView.sd_setImage(with: URL(string: newString), placeholderImage: UIImage(named: "movie"))
            imageView.sd_setImage(with: URL(string: image), placeholderImage: UIImage(named: "movie"))
           
        }
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    
    private func initialize() {
        addSubview(backgroundView)
        backgroundView.anchorToSuperview()
        backgroundView.addSubview(imageView)
        imageView.anchorToSuperview()
        applyShadow(radius: 8, opacity: 0.2, offset: CGSize(width: 0, height: 2))
        backgroundView.layer.insertSublayer(gradientLayer, above: imageView.layer)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let heightFactor: CGFloat = 0.35
        gradientLayer.frame = CGRect(x: 0,
                                     y: (1 - heightFactor) * bounds.height,
                                     width: bounds.width,
                                     height: heightFactor * bounds.height)
    }
}
