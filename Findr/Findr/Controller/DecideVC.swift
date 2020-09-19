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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.xButton.addTarget(self, action: #selector(xOut), for: UIControl.Event.touchUpInside)
    }
    
    @objc func xOut() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func loadView() {
        self.view = decideView
    }
    
    
}
