//
//  StartSessionVC.swift
//  Findr
//
//  Created by Vlad Munteanu on 9/18/20.
//

import Foundation
import UIKit
import SnapKit
import PopupDialog

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
        
        if let val = userInfo["type"] as? String {
            if val == "food" {
                if let rating = userInfo["rating"] as? MinRating, let range = userInfo["pricerange"] as? PriceRange {
                    print("Rating: \(rating)")
                    print("Range: \(range)")
                    
//                    SessionManager.shared.startFoodSession(rating: rating, range: range, completion: {
//                        sesh in
//                        
//                        
//                    })
                    
                    
                } else {
                    idkError()
                }
            } else if val == "movie" {
                if let genre = userInfo["genre"] as? movieGenre, let kind = userInfo["kind"] as? movieKind {
                    print("Genre: \(genre)")
                    print("Kind: \(kind)")
                } else {
                    idkError()
                }
            } else {
                idkError()
            }
        } else {
            idkError()
        }
    }
    
    func idkError() {
        let title = "Something went wrong"
        let message = "Your request to generate a session was unsucessful, please try again."
        let image = UIImage(named: "errorguy")

        // Create the dialog
        let popup = PopupDialog(title: title, message: message, image: image)

        // Create buttons
        let buttonOne = CancelButton(title: "Ok") {
        }


        // Add buttons to dialog
        // Alternatively, you can use popup.addButton(buttonOne)
        // to add a single button
        popup.addButtons([buttonOne])

        // Present dialog
        self.present(popup, animated: true, completion: nil)
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
    
    func goToSwipe() {
        let transition = CATransition()
        transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        
        let vc = SwipeVC()
        vc.modalPresentationStyle = .fullScreen
        self.view.window!.layer.add(transition, forKey: nil)
        self.present(vc, animated: false)
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
