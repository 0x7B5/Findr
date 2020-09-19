//
//  SignUpView.swift
//  Findr
//
//  Created by Vlad Munteanu on 9/18/20.
//

import Foundation
import UIKit
import SnapKit

public class SignUpView: UIView {
    
    var createState = true
    
    // Background Image
    // Title
    // Subtitle
    // Create Account Button
    // Sign In Button
    // Sign In w/ Facebook Button
    // Sign In w/ email
    // Continue as guest
    
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
        addSubview(bgView)
        addSubview(title)
        addSubview(subtitle)
        addSubview(createAccount)
        addSubview(signIn)
        
        addSubview(signFB)
        addSubview(signEmail)
        addSubview(continueGuest)
        addSubview(backButton)
        
        if createState {
            signFB.isHidden = true
            signEmail.isHidden = true
            continueGuest.isHidden = true
            backButton.isHidden = true
            
            
            
            signFB.snp.remakeConstraints {
                $0.width.equalToSuperview().multipliedBy(0.78)
                $0.height.equalTo(signFB.snp.width).multipliedBy(0.18)
                $0.centerX.equalToSuperview()
                $0.centerY.equalToSuperview().multipliedBy(3.0)
            }
            
            signEmail.snp.remakeConstraints {
                $0.width.equalToSuperview().multipliedBy(0.78)
                $0.height.equalTo(signEmail.snp.width).multipliedBy(0.18)
                $0.centerX.equalToSuperview()
                $0.centerY.equalToSuperview().multipliedBy(3.0)
            }
            
            continueGuest.snp.remakeConstraints {
                $0.width.equalTo(createAccount.snp.width)
                $0.height.equalTo(createAccount.snp.height)
                $0.centerX.equalToSuperview()
                $0.centerY.equalToSuperview().multipliedBy(1.89)
            }
            
            backButton.snp.remakeConstraints {
                $0.width.equalToSuperview().multipliedBy(0.08)
                $0.height.equalTo(backButton.snp.width)
                $0.centerY.equalToSuperview().multipliedBy(1.45)
                $0.left.equalToSuperview().inset(5)
            }
        }
    }
    
    public func createConstraints() {
        
        bgView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        title.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(0.3)
        }
        
        subtitle.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.top.equalTo(title.snp.bottom).offset(12)
        }
        
        createAccount.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.78)
            $0.height.equalTo(createAccount.snp.width).multipliedBy(0.18)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(1.75)
        }
        
        signIn.snp.makeConstraints {
            $0.width.equalTo(createAccount.snp.width)
            $0.height.equalTo(createAccount.snp.height)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(1.89)
        }
        
    }
    
    public let bgView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return view
    }()
    
    
    public let title: UILabel = {
        let label = UILabel()
        label.font = UIFont(name:"Georgia",size:50)
        label.adjustsFontForContentSizeCategory = true
        label.text = "Findr"
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        // label.textColor = Constants.subTitleColor
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    
    public let subtitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 23, weight: UIFont.Weight.light)
        label.adjustsFontForContentSizeCategory = true
        label.text = "More time together."
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        // label.textColor = Constants.subTitleColor
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    
    public lazy var createAccount = self.createButton(title: "Create Account", color: Constants.mainColor)
    
    public let signIn: CurvedButton = {
        let button = CurvedButton(color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0))
        button.setTitle("Sign in", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.medium)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        return button
    }()
    
    public lazy var signFB = self.createButton(title: "Sign in with Facebook", color: Constants.fbColor)
    public lazy var signEmail = self.createButton(title: "Sign in with email", color: Constants.mainColor)
    
    public let continueGuest: CurvedButton = {
        let button = CurvedButton(color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0))
        button.setTitle("Continue as guest", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.medium)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        return button
    }()
    
    public let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "backarrow"), for: UIControl.State.normal)
//        button.setTitle("Back", for: .normal)
//        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.medium)
//        button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: UIControl.State.normal)
//        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        return button
    }()
    
    
    
    
    func createButton(title: String, color: UIColor) -> CurvedButton {
        let button = CurvedButton(color: color)
        button.setTitle(title, for: .normal)
        button.backgroundColor = color
        return button
    }
    
    func toggleView() {
        
        if createState {
            createState = false
            
            UIView.animate(withDuration: 0.1) { [self] in
                createAccount.snp.remakeConstraints {
                    $0.width.equalToSuperview().multipliedBy(0.78)
                    $0.height.equalTo(createAccount.snp.width).multipliedBy(0.18)
                    $0.centerX.equalToSuperview()
                    $0.centerY.equalToSuperview().multipliedBy(1.6)
                }
                
                signFB.snp.remakeConstraints {
                    $0.width.equalToSuperview().multipliedBy(0.78)
                    $0.height.equalTo(signFB.snp.width).multipliedBy(0.18)
                    $0.centerX.equalToSuperview()
                    $0.centerY.equalToSuperview().multipliedBy(1.6)
                }
                
                signEmail.snp.remakeConstraints {
                    $0.width.equalToSuperview().multipliedBy(0.78)
                    $0.height.equalTo(signEmail.snp.width).multipliedBy(0.18)
                    $0.centerX.equalToSuperview()
                    $0.centerY.equalToSuperview().multipliedBy(1.75)
                }
                
                signFB.isHidden = false
                signEmail.isHidden = false
                continueGuest.isHidden = false
                
                createAccount.superview?.layoutIfNeeded()
            }
            
            signIn.isHidden = true
            backButton.isHidden = false
            let seconds = 0.1
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) { [self] in
                createAccount.isHidden = true
            }
            
            continueGuest.snp.remakeConstraints {
                $0.width.equalTo(createAccount.snp.width)
                $0.height.equalTo(createAccount.snp.height)
                $0.centerX.equalToSuperview()
                $0.centerY.equalToSuperview().multipliedBy(1.89)
            }
            
            
            
        } else {
            createState = true
            
            
            UIView.animate(withDuration: 0.1) { [self] in
                
                signFB.snp.remakeConstraints {
                    $0.width.equalToSuperview().multipliedBy(0.78)
                    $0.height.equalTo(signFB.snp.width).multipliedBy(0.18)
                    $0.centerX.equalToSuperview()
                    $0.centerY.equalToSuperview().multipliedBy(1.2)
                }
                
                signEmail.snp.remakeConstraints {
                    $0.width.equalToSuperview().multipliedBy(0.78)
                    $0.height.equalTo(signEmail.snp.width).multipliedBy(0.18)
                    $0.centerX.equalToSuperview()
                    $0.centerY.equalToSuperview().multipliedBy(1.4)
                }
                
                continueGuest.snp.makeConstraints {
                    $0.width.equalTo(createAccount.snp.width)
                    $0.height.equalTo(createAccount.snp.height)
                    $0.centerX.equalToSuperview()
                    $0.centerY.equalToSuperview().multipliedBy(1.6)
                }
                
                createAccount.snp.makeConstraints {
                    $0.width.equalToSuperview().multipliedBy(0.78)
                    $0.height.equalTo(createAccount.snp.width).multipliedBy(0.18)
                    $0.centerX.equalToSuperview()
                    $0.centerY.equalToSuperview().multipliedBy(1.75)
                }
                
                createAccount.isHidden = false
                signIn.isHidden = false
                
                createAccount.superview?.layoutIfNeeded()
            }
            
            continueGuest.isHidden = true
            
            let seconds = 0.1
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) { [self] in
                signFB.isHidden = true
                signEmail.isHidden = true
                backButton.isHidden = true
            }
            
            signIn.snp.makeConstraints {
                $0.width.equalTo(createAccount.snp.width)
                $0.height.equalTo(createAccount.snp.height)
                $0.centerX.equalToSuperview()
                $0.centerY.equalToSuperview().multipliedBy(1.89)
            }
            
            signFB.snp.remakeConstraints {
                $0.width.equalToSuperview().multipliedBy(0.78)
                $0.height.equalTo(signFB.snp.width).multipliedBy(0.18)
                $0.centerX.equalToSuperview()
                $0.centerY.equalToSuperview().multipliedBy(3.0)
            }
            
            signEmail.snp.remakeConstraints {
                $0.width.equalToSuperview().multipliedBy(0.78)
                $0.height.equalTo(signEmail.snp.width).multipliedBy(0.18)
                $0.centerX.equalToSuperview()
                $0.centerY.equalToSuperview().multipliedBy(3.0)
            }
            
            continueGuest.snp.remakeConstraints {
                $0.width.equalTo(createAccount.snp.width)
                $0.height.equalTo(createAccount.snp.height)
                $0.centerX.equalToSuperview()
                $0.centerY.equalToSuperview().multipliedBy(1.89)
            }
        }
        
    }
}
