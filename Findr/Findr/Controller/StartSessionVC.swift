//
//  StartSessionVC.swift
//  Findr
//
//  Created by Vlad Munteanu on 9/18/20.
//

import Foundation
import UIKit
import QuickTableViewController
import SnapKit


/*
 Movie:
 Kind: TV Shows, or movies
 Genre
 
 
 Food:
 Max Distance
 Expensive
 */

class StartSessionVC: UIViewController {
    
    lazy var seshView = StartSessionView()
    
    unowned var customSC: UISegmentedControl { return seshView.customSC }
    unowned var backButton: UIButton { return seshView.backButton }
    
    //
    
//    var mySession: Session
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.backButton.addTarget(self, action: #selector(goBack), for: UIControl.Event.touchUpInside)
        
        customSC.addTarget(self, action: #selector(setSeshType), for: .valueChanged)
        
    }
    
    @objc func setSeshType() {
        print(customSC.selectedSegmentIndex)
        
    }
    
    
    
    @objc func goBack() {
        let transition = CATransition()
        transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: nil)
        self.dismiss(animated: false, completion: nil)
    }
    
    
    override func loadView() {
        self.view = seshView
    }
    
    
}
