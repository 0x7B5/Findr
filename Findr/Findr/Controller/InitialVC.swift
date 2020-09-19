//
//  ViewController.swift
//  Findr
//
//  Created by Vlad Munteanu on 9/18/20.
//

import UIKit
import SwiftVideoBackground
import PopupDialog

class InitialVC: UIViewController {
   
    
    lazy var signUpView = SignUpView()
    unowned var bgView: UIView { return signUpView.bgView}
    
    // Buttons
    unowned var signIn: UIButton { return signUpView.signIn }
    unowned var signFB: UIButton { return signUpView.signFB }
    unowned var signEmail: UIButton { return signUpView.signEmail }
    unowned var continueGuest: UIButton { return signUpView.continueGuest }
    unowned var createButton: UIButton { return signUpView.createAccount }
    unowned var backButton: UIButton { return signUpView.backButton }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addButtons()
        
        try? VideoBackground.shared.play(
            view: bgView,
            videoName: "nyc",
            videoType: "mp4",
            isMuted: true, darkness: 0.25,
            willLoopVideo: true,
            setAudioSessionAmbient: false
        )
    }
    

    
    func addButtons() {
        self.signFB.addTarget(self, action: #selector(signFBFunc), for: UIControl.Event.touchUpInside)
        self.signIn.addTarget(self, action: #selector(signInFunc), for: UIControl.Event.touchUpInside)
        self.signEmail.addTarget(self, action: #selector(signEmailFunc), for: UIControl.Event.touchUpInside)
        self.continueGuest.addTarget(self, action: #selector(guestFunc), for: UIControl.Event.touchUpInside)
        self.createButton.addTarget(self, action: #selector(createButtonFunc), for: UIControl.Event.touchUpInside)
        self.backButton.addTarget(self, action: #selector(backButtonFunc), for: UIControl.Event.touchUpInside)
        
    }
    
    @objc func backButtonFunc() {
        signUpView.toggleView()
        
    }
    
    @objc func createButtonFunc() {
        let title = "Create Account"
        let message = "Although you can use our app without creating an account, registering allows us to provide you with even better suggestions."
        let image = UIImage(named: "16")

        // Create the dialog
        let popup = PopupDialog(title: title, message: message, image: image)

        // Create buttons
        let buttonOne = CancelButton(title: "Cancel") {
        }

        // This button will not the dismiss the dialog
        let buttonTwo = DefaultButton(title: "Let's Register", dismissOnTap: true) {
            
        }


        // Add buttons to dialog
        // Alternatively, you can use popup.addButton(buttonOne)
        // to add a single button
        popup.addButtons([buttonTwo, buttonOne])

        // Present dialog
        self.present(popup, animated: true, completion: nil)
        
    }
    
    @objc func signFBFunc() {
        
    }
    
    @objc func signInFunc() {
        signUpView.toggleView()
        
    }
    
    @objc func signEmailFunc() {
        
    }
    
    @objc func guestFunc() {
        
        
    }
    
   
    
    override func loadView() {
        self.view = signUpView
    }
}

