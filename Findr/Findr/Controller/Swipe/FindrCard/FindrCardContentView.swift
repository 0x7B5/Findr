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
            
            let copy = image
            
            var fullNameArr = copy.components(separatedBy: "/")
            
            
            
           
            
            let newStringTwo = fullNameArr[0] + "//" + fullNameArr[2] + "/" + "content/movie/" + fullNameArr[5] + "poster-342.jpg"
            let newStringThree = fullNameArr[0] + "//" + fullNameArr[2] + "/" + "content/show/" + fullNameArr[5] + "/poster-780.jpg"
            let newStringFoo = fullNameArr[0] + "//" + fullNameArr[2] + "/" + "content/show/" + fullNameArr[5] + "poster-342.jpg"
            
            print(newStringTwo)
            print(newStringThree)
            print(newStringFoo)
           
            imageView.sd_setImage(with: URL(string: image)) { [self] (newImage, error, cache, urls) in
                if (error != nil) {
                    let newString = fullNameArr[0] + "//" + fullNameArr[2] + "/" + "content/movie/" + fullNameArr[5] + "/poster-780.jpg"
                    print(newString)
                    imageView.sd_setImage(with: URL(string: newString)) { [self] (newImage, error, cache, urls) in
                        if (error != nil) {
                            imageView.sd_setImage(with: URL(string: newStringTwo)) { [self] (newImage, error, cache, urls) in
                                if (error != nil) {
                                    imageView.sd_setImage(with: URL(string: newStringThree)) { [self] (newImage, error, cache, urls) in
                                        if (error != nil) {
                                            imageView.sd_setImage(with: URL(string: newStringFoo)) { [self] (newImage, error, cache, urls) in
                                                if (error != nil) {
                                                    imageView.image = UIImage(named: "movie")
                                                } else {
                                                    imageView.image = newImage
                                                }
                                            }
                                            
                                        } else {
                                            imageView.image = newImage
                                        }
                                    }
                                } else {
                                    imageView.image = newImage
                                }
                            }
                            
                        } else {
                            imageView.image = newImage
                        }
                    }
                    
                    
                    
                    
                    
                } else {
                    //Success code here
                    imageView.image = newImage
                }
            }
            
            
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
