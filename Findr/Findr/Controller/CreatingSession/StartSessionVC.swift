//
//  StartSessionVC.swift
//  Findr
//
//  Created by Vlad Munteanu on 9/18/20.
//

import Foundation
import UIKit
import SnapKit


enum currentSessionState  {
    case movie, food, none
}

/*
 Movie:
 Kind: TV Shows, or movies
 Genre
 
 
 Food:
 Max Distance
 Expensive
 */

class StartSessionVC: UIViewController {
    
    var childVC: UIViewController? = nil
    lazy var seshView = StartSessionView()
    var currentState: currentSessionState = .none
    
    unowned var customSC: UISegmentedControl { return seshView.customSC }
    unowned var backButton: UIButton { return seshView.backButton }
    unowned var emptyView: UIView { return seshView.emptyView}
    
    let nc = NotificationCenter.default
    
    
    
    //
    
    //    var mySession: Session
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.backButton.addTarget(self, action: #selector(goBack), for: UIControl.Event.touchUpInside)
        
        customSC.addTarget(self, action: #selector(setSeshType), for: .valueChanged)
        nc.addObserver(self, selector: #selector(startSesh), name: NSNotification.Name(rawValue: "printValue"), object: nil)
        
    }
    
    @objc func startSesh(notification:NSNotification) {
        let userInfo:Dictionary<String,Any> = notification.userInfo as! Dictionary<String,Any>
        
        
        print(userInfo)
    }
    
    
    @objc func setSeshType() {
        switch customSC.selectedSegmentIndex {
        case 0:
            changeState(state: .food)
        case 1:
            changeState(state: .movie)
        default:
            print("idk")
        }
    }
    
    func changeState(state: currentSessionState) {
        if currentState == .none || state != currentState {
            if state == .food {
                if childVC != nil {
                    childVC!.willMove(toParent: nil)
                    childVC!.removeFromParent()
                    childVC!.view.removeFromSuperview()
                }
                childVC = ResturantSesssionVC()
                self.addChild(childVC!)
                emptyView.addSubview(childVC!.view)
                childVC!.didMove(toParent: self)
            } else if state == .movie {
                if childVC != nil {
                    childVC!.willMove(toParent: nil)
                    childVC!.removeFromParent()
                    childVC!.view.removeFromSuperview()
                }
                childVC = MovieSessionVC()
                self.addChild(childVC!)
                emptyView.addSubview(childVC!.view)
                childVC!.didMove(toParent: self)
            }
        }
        
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
