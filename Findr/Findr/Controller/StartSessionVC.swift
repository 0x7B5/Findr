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

class StartSessionVC: QuickTableViewController {
    
//    var mySession: Session
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMovie()
    }
    
    func setupMovie() {
        tableContents = [
              RadioSection(title: "What Kind?", options: [
                OptionRow(text: "Movies", isSelected: true, action: {_ in
                    print("Movies")
                }),
                OptionRow(text: "TV Shows", isSelected: false, action: {_ in
                }),
                OptionRow(text: "Both", isSelected: false, action: {_ in
                })
              ], footer: "See RadioSection for more details.")
            ]
        
    }
    
    func setupFood() {
        
    }
}
