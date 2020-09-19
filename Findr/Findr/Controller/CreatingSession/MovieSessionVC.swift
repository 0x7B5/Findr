//
//  MovieSessionVC.swift
//  Findr
//
//  Created by Vlad Munteanu on 9/18/20.
//

import Foundation
import UIKit
import QuickTableViewController
import SnapKit

class MovieSessionVC: QuickTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableContents = [
            RadioSection(title: "What kind?", options: [
                OptionRow(text: "Movies", isSelected: true, action: {_ in
                    
                }),
                OptionRow(text: "TV Shows", isSelected: false, action: {_ in
                    
                }),
                OptionRow(text: "Both", isSelected: false, action: {_ in
                    
                })
            ], footer: ""),
            RadioSection(title: "Any specific genre?", options: [
                OptionRow(text: "Comedy", isSelected: true, action: {_ in
                    
                }),
                OptionRow(text: "Action", isSelected: false, action: {_ in
                    
                }),
                OptionRow(text: "Horror", isSelected: false, action: {_ in
                    
                }),
                OptionRow(text: "Romance", isSelected: false, action: {_ in
                    
                }),
                OptionRow(text: "Any", isSelected: false, action: {_ in
                    
                })
            ], footer: ""),
            
            Section(title: "", rows: [
                TapActionRow(text: "Start Session", action: { _ in
                    print("woahh")
                })
            ])
        ]
    }
    
    
}
