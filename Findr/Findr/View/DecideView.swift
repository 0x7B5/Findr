//
//  DecideView.swift
//  Findr
//
//  Created by Vlad Munteanu on 9/18/20.
//

import Foundation
import UIKit
import SnapKit

public class DecideView: UIView {
    
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
        addSubview(xButton)
        addSubview(bgView)
        bgView.addSubview(walkImage)
        bgView.addSubview(cantDecide)
        bgView.addSubview(helpLbl)
        bgView.addSubview(startButton)
        bgView.addSubview(joinButton)
    }
    
    public func createConstraints() {
        xButton.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.1)
            $0.height.equalTo(xButton.snp.width)
            $0.right.equalToSuperview().inset(10)
            $0.top.equalToSuperview().inset(40)
        }
        
        bgView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalToSuperview().multipliedBy(0.7)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(1.05)
        }
        
        walkImage.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.4)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(0.5)
        }
        
        cantDecide.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.top.equalTo(walkImage.snp.bottom).offset(20)
            $0.left.equalToSuperview().inset(10)
        }
        helpLbl.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.top.equalTo(cantDecide.snp.bottom).inset(10)
            $0.left.equalToSuperview().inset(10)
        }
        
        startButton.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalTo(startButton.snp.width).multipliedBy(0.18)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(1.55)
        }
        
        joinButton.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalTo(startButton.snp.width).multipliedBy(0.18)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(1.8)
        }
        
        
        
    }
    
    
    public let xButton: CurvedButton = {
        let button = CurvedButton(color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0))
        button.setTitle("X", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 23, weight: UIFont.Weight.light)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: UIControl.State.normal)
        button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        
        return button
    }()
    
    public let bgView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        view.layer.cornerRadius = 10
        return view
    }()
    
    public let walkImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "decideee")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    public let cantDecide: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 43, weight: UIFont.Weight.semibold)
        label.adjustsFontForContentSizeCategory = true
        label.text = "Can't Decide?"
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    public let helpLbl: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 43, weight: UIFont.Weight.semibold)
        label.adjustsFontForContentSizeCategory = true
        label.text = "We can help."
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    public lazy var startButton = self.createButton(title: "Start Session", color: Constants.mainColor)
    public lazy var joinButton = self.createButton(title: "Join Session", color: Constants.secondColor)
    
    
    func createButton(title: String, color: UIColor) -> CurvedButton {
        let button = CurvedButton(color: color)
        button.setTitle(title, for: .normal)
        button.backgroundColor = color
        return button
    }
}
