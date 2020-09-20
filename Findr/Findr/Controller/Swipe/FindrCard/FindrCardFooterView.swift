//
//  FindrCardFooterView.swift
//  Findr
//
//  Created by Vlad Munteanu on 9/20/20.
//

import UIKit

public class FindrCardFooterView: UIView {
    
    private var label = UILabel()
    private var rating = UILabel()
    
    private var gradientLayer: CAGradientLayer?
    
    public init(withTitle title: String?, subtitle: String?, score: Double?) {
        super.init(frame: CGRect.zero)
        
        backgroundColor = .clear
        layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        layer.cornerRadius = 20
        clipsToBounds = true
        isOpaque = false
        initialize(title: title, subtitle: subtitle, score: score!)
    }
    
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialize(title: String?, subtitle: String?, score: Double) {
        let attributedText = NSMutableAttributedString(string: (title ?? "") + "\n",
                                                       attributes: NSAttributedString.Key.titleAttributes)
        if let subtitle = subtitle, !subtitle.isEmpty {
            attributedText.append(NSMutableAttributedString(string: subtitle,
                                                            attributes: NSAttributedString.Key.subtitleAttributes))
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 4
            paragraphStyle.lineBreakMode = .byClipping
            attributedText.addAttributes([NSAttributedString.Key.paragraphStyle: paragraphStyle],
                                         range: NSRange(location: 0, length: attributedText.length))
            label.numberOfLines = 2
        }
        
        label.attributedText = attributedText
        label.adjustsFontSizeToFitWidth = true
        
        rating = {
            let label = UILabel()
            label.textColor = #colorLiteral(red: 0.9305164125, green: 0.9305164125, blue: 0.9305164125, alpha: 1)
            label.text = "\(score.rounded(toPlaces: 1))✰"
            label.font = UIFont.systemFont(ofSize: 33, weight: UIFont.Weight.regular)
            return label
            
        }()
        
        addSubview(rating)
        addSubview(label)
    }
    
    public override func layoutSubviews() {
        let padding: CGFloat = 20
        label.frame = CGRect(x: padding,
                             y: bounds.height - label.intrinsicContentSize.height - padding,
                             width: bounds.width * 0.60,
                             height: label.intrinsicContentSize.height)
        rating.frame = CGRect(x: bounds.width - 95,
                              y: bounds.height - rating.intrinsicContentSize.height - 13,
                              width: bounds.width - 2 * padding,
                              height: rating.intrinsicContentSize.height)
    }
}

extension NSAttributedString.Key {
    
    static var shadowAttribute: NSShadow = {
        let shadow = NSShadow()
        shadow.shadowOffset = CGSize(width: 0, height: 1)
        shadow.shadowBlurRadius = 2
        shadow.shadowColor = UIColor.black.withAlphaComponent(0.3)
        return shadow
    }()
    
    static var titleAttributes: [NSAttributedString.Key: Any] = [
        // swiftlint:disable:next force_unwrapping
        NSAttributedString.Key.font: UIFont(name: "ArialRoundedMTBold", size: 22)!,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.shadow: NSAttributedString.Key.shadowAttribute
    ]
    
    static var subtitleAttributes: [NSAttributedString.Key: Any] = [
        // swiftlint:disable:next force_unwrapping
        NSAttributedString.Key.font: UIFont(name: "Arial", size: 17)!,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.shadow: NSAttributedString.Key.shadowAttribute
    ]
}

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
