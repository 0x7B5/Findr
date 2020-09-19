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
        
        var rating: MinRating = .any
        var priceRange: PriceRange = .any
        
        let prRow = RadioSection(title: "Price Range?", options: [
            OptionRow(text: "$$$", isSelected: false, action: {_ in
                priceRange = .three
            }),
            OptionRow(text: "$$", isSelected: false, action: {_ in
                priceRange = .two
            }),
            OptionRow(text: "$", isSelected: false, action: {_ in
                priceRange = .one
            }),
            OptionRow(text: "Any", isSelected: true, action: {_ in
                priceRange = .any
            })
        ], footer: "")
        
        prRow.alwaysSelectsOneOption = true
        
        let minRatingRow = RadioSection(title: "Minimum Rating?", options: [
            OptionRow(text: "⭐⭐⭐⭐⭐", isSelected: false, action: {_ in
                rating = .five
            }),
            OptionRow(text: "⭐⭐⭐⭐", isSelected: false, action: {_ in
                rating = .four
            }),
            OptionRow(text: "⭐⭐⭐", isSelected: false, action: {_ in
                rating = .three
            }),
            OptionRow(text: "Any", isSelected: true, action: {_ in
                rating = .any
            })
        ], footer: "")
        
        minRatingRow.alwaysSelectsOneOption = true
        
        tableContents = [
            prRow,
            minRatingRow,
            Section(title: "", rows: [
                TapActionRow(text: "Start Session", action: { _ in
                    let nc = NotificationCenter.default
                    nc.post(name: NSNotification.Name(rawValue: "printValue"), object: nil, userInfo: ["type": "food", "rating" : rating, "pricerange" : priceRange])
                })
            ])
        ]
    }
}
