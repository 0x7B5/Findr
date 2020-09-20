//
//  TextfieldVC.swift
//  Findr
//
//  Created by Vlad Munteanu on 9/20/20.
//

import Foundation
import UIKit
import SnapKit

class TextfieldVC: UIViewController {
    
    lazy var tfView = TFView()
    unowned var tfYuh: UITextField {return tfView.tf}
    
    
    override func loadView() {
        self.view = tfView
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        tfYuh.delegate = self
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(endEditing)))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func endEditing() {
        view.endEditing(true)
    }
}

extension TextfieldVC: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing()
        return true
    }
}
