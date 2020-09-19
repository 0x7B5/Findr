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
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func startSesh() {
        let vc = StartSessionVC()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
        
    }
    
    @objc func joinSesh() {
        
    }
    
    override func loadView() {
        self.view = decideView
    }
    
    
}
