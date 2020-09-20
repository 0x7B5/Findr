//
//  MovieFooterView.swift
//  Findr
//
//  Created by Vlad Munteanu on 9/20/20.
//

import Foundation
import UIKit
import SnapKit

public class MovieFooterView: UIView {
    
    var myMovie: Movie
    
    public init(movie: Movie) {
        myMovie = movie
        super.init(frame: CGRect.zero)
        self.frame = CGRect.zero
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        //layer.cornerRadius = 20
        
        initializeUI()
        createConstraints()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initializeUI() {
        addSubview(temp)
        temp.addSubview(titleLabel)
        temp.addSubview(genreLabel)
        temp.addSubview(overviewLabel)
        
        titleLabel.text = myMovie.title
        
        var titleSet = false
        for i in myMovie.genre {
            if i == 5 {
                genreLabel.text = "Action"
                titleSet = true
                break
            } else if i == 9 {
                genreLabel.text = "Comedy"
                titleSet = true
                break
            } else if i == 19 {
                genreLabel.text = "Horror"
                titleSet = true
                break
            } else if i == 4 {
                genreLabel.text = "Romance"
                titleSet = true
                break
            }
        }
        
        if !titleSet {
            genreLabel.text = "Various Genres"
        }
        
        overviewLabel.text = myMovie.description
        
        
    }
    
    public func createConstraints() {
        temp.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(2.0)
            $0.centerY.equalToSuperview().multipliedBy(0.3)
        }
        
        titleLabel.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.6)
            $0.left.equalToSuperview().inset(10)
            $0.top.equalToSuperview().inset(-5)
        }
        
        genreLabel.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.6)
            $0.left.equalToSuperview().inset(10)
            $0.top.equalTo(titleLabel.snp.bottom)
        }
        
        overviewLabel.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(genreLabel.snp.bottom)
        }
        
        
        
    }
    
    let temp: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        view.layer.cornerRadius = 20
        return view
    }()
    
    public let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 40, weight: UIFont.Weight.semibold)
        label.adjustsFontForContentSizeCategory = true
//        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    public let genreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.regular)
        label.adjustsFontForContentSizeCategory = true
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = #colorLiteral(red: 0.4666666667, green: 0.4549019608, blue: 0.4549019608, alpha: 1)
        return label
    }()
    
    public let overviewLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.regular)
        label.adjustsFontForContentSizeCategory = true
//        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.numberOfLines = 3
        label.textColor = #colorLiteral(red: 0.4666666667, green: 0.4549019608, blue: 0.4549019608, alpha: 1)
        return label
    }()
    
    
}

extension UIView {

    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
         let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
         let mask = CAShapeLayer()
         mask.path = path.cgPath
         self.layer.mask = mask
    }

}
