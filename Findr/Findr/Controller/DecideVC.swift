//
//  DecideVC.swift
//  Findr
//
//  Created by Vlad Munteanu on 9/18/20.
//

import Foundation
import UIKit


class DecideVC: UIViewController {
    lazy var decideView = DecideView()
    
    // Buttons
    unowned var xButton: UIButton { return decideView.xButton }
    unowned var startButton: UIButton { return decideView.startButton }
    unowned var joinButton: UIButton { return decideView.joinButton }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.xButton.addTarget(self, action: #selector(xOut), for: UIControl.Event.touchUpInside)
        self.startButton.addTarget(self, action: #selector(startSesh), for: UIControl.Event.touchUpInside)
        self.joinButton.addTarget(self, action: #selector(joinSesh), for: UIControl.Event.touchUpInside)
    }
    
    @objc func xOut() {
        let transition = CATransition()
        transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromBottom
        
        let vc = InitialVC()
        vc.modalPresentationStyle = .fullScreen
        self.view.window!.layer.add(transition, forKey: nil)
        self.present(vc, animated: false)
    }
    
    @objc func startSesh() {
        let transition = CATransition()
        transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        
        let vc = StartSessionVC()
        vc.modalPresentationStyle = .fullScreen
        self.view.window!.layer.add(transition, forKey: nil)
        self.present(vc, animated: false)
        
    }
    
    @objc func joinSesh() {
        
    }
    
    override func loadView() {
        self.view = decideView
    }
    
    
}
