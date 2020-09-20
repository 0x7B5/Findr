//
//  DecideVC.swift
//  Findr
//
//  Created by Vlad Munteanu on 9/18/20.
//

import Foundation
import UIKit
import PopupDialog


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
        var inputTextField: UITextField?
        
        //Create the AlertController
        let actionSheetController: UIAlertController = UIAlertController(title: "Join Session", message: "Enter code", preferredStyle: .alert)
        
        //Create and add the Cancel action
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            //Do some stuff
        }
        actionSheetController.addAction(cancelAction)
        //Create and an option action
        let nextAction: UIAlertAction = UIAlertAction(title: "OK", style: .default) { action -> Void in
            print(inputTextField?.text)
            let yuh = SessionManager.shared.getMovieSession(key: (inputTextField?.text!)!, completion: {
                hey in
                
            })
           
        }
        actionSheetController.addAction(nextAction)
        //Add a text field
        actionSheetController.addTextField { textField -> Void in
            // you can use this text field
            inputTextField = textField
            
        }
        
        //Present the AlertController
        self.present(actionSheetController, animated: true, completion: nil)
    }
    
    func startMovieSesh(sesh: MovieSession) {
        let transition = CATransition()
        transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        
        let vc = SwipeVC()
        vc.movieSesh = sesh
        vc.myType = .movie
        vc.user1 = false
        vc.modalPresentationStyle = .fullScreen
        self.view.window!.layer.add(transition, forKey: nil)
        self.present(vc, animated: false)
    }
    
    override func loadView() {
        self.view = decideView
    }
    
    
}
