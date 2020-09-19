//
//  ResturantSessionVC.swift
//  Findr
//
//  Created by Vlad Munteanu on 9/18/20.
//

import Foundation
import UIKit
import QuickTableViewController

class ResturantSesssionVC: QuickTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        #warning("Add slider for distance")
        
        tableContents = [
            RadioSection(title: "Price Range?", options: [
                OptionRow(text: "$$$", isSelected: true, action: {_ in
                
                }),
                OptionRow(text: "$$", isSelected: false, action: {_ in
                    
                }),
                OptionRow(text: "$", isSelected: false, action: {_ in
                    
                }),
                OptionRow(text: "Any", isSelected: false, action: {_ in
                    
                })
            ], footer: ""),
            RadioSection(title: "Minimum Rating?", options: [
                OptionRow(text: "⭐⭐⭐⭐⭐", isSelected: true, action: {_ in
                
                }),
                OptionRow(text: "⭐⭐⭐⭐", isSelected: false, action: {_ in
                    
                }),
                OptionRow(text: "⭐⭐⭐", isSelected: false, action: {_ in
                    
                }),
                OptionRow(text: "Any", isSelected: false, action: {_ in
                    
                })
            ], footer: ""),
            Section(title: "", rows: [
                TapActionRow(text: "Start Session", action: { _ in
                })
            ])
        ]
    }
}
