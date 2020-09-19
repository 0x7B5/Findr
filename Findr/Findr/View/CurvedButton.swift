//
//  CurvedButton.swift
//  Findr
//
//  Created by Vlad Munteanu on 9/18/20.
//

import Foundation
import UIKit
import TKSubmitTransition

public class CurvedButton: UIButton {
    
    var bgColor: UIColor
    
    override open var isHighlighted: Bool {
        didSet {
            if bgColor == #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) {
                titleLabel?.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            } else {
                backgroundColor = isHighlighted ? (self.bgColor.darker(by: 12) ?? self.bgColor) : self.bgColor
                titleLabel?.textColor = isHighlighted ? (#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)) : UIColor.white
            }
        }
    }
    
    init(color: UIColor) {
        self.bgColor = color
        super.init(frame: CGRect.zero)
        self.setTitleColor(UIColor.white, for: .normal)
        self.layer.cornerRadius = 20
    }
    
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
