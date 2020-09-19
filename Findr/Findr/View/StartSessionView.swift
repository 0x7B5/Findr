//
//  StartSessionView.swift
//  Findr
//
//  Created by Vlad Munteanu on 9/18/20.
//

import Foundation
import UIKit
import SnapKit

public class StartSessionView: UIView {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = CGRect.zero
        backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        initializeUI()
        createConstraints()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initializeUI() {
        addSubview(backButton)
        addSubview(startLbl)
        addSubview(customSC)
        
        
    }
    
    public func createConstraints() {
        backButton.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.07)
            $0.height.equalTo(backButton.snp.width)
            $0.centerY.equalToSuperview().multipliedBy(0.222)
            $0.left.equalToSuperview().inset(15)
        }
        
        startLbl.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.92)
            $0.height.equalToSuperview().multipliedBy(0.1)
            $0.centerY.equalToSuperview().multipliedBy(0.22)
            $0.centerX.equalToSuperview().multipliedBy(1.3)
        }
        
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        customSC.setTitleTextAttributes(titleTextAttributes, for: .normal)
        customSC.setTitleTextAttributes(titleTextAttributes, for: .selected)
        customSC.selectedSegmentTintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        
        customSC.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.centerX.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.05)
            $0.centerY.equalToSuperview().multipliedBy(0.4)
        }
        
    }
    
    // Button
    // Lets start a session label
    // Segmented control
    // Radio Buttons 1
    // Radio Buttons 2
    // Lets go button
    
    public let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "blackarrow"), for: UIControl.State.normal)
        button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        return button
    }()
    
    public let startLbl: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30, weight: UIFont.Weight.semibold)
        label.adjustsFontForContentSizeCategory = true
        label.text = "Let's start a session"
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    public let customSC = UISegmentedControl(items: ["Resturants","Movies"])
}
