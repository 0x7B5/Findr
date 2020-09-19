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
        
        var kind: movieKind = .both
        var genre: movieGenre = .any
        
        let kindRow = RadioSection(title: "What kind?", options: [
            OptionRow(text: "Movies", isSelected: false, action: {_ in
                kind = .movie
            }),
            OptionRow(text: "TV Shows", isSelected: false, action: {_ in
                kind = .tvshow
            }),
            OptionRow(text: "Both", isSelected: true, action: {_ in
                kind = .both
            })
        ], footer: "")
        
        let genreRow = RadioSection(title: "Any specific genre?", options: [
            OptionRow(text: "Comedy", isSelected: false, action: {_ in
                genre = .comedy
            }),
            OptionRow(text: "Action", isSelected: false, action: {_ in
                genre = .action
            }),
            OptionRow(text: "Horror", isSelected: false, action: {_ in
                genre = .horror
            }),
            OptionRow(text: "Romance", isSelected: false, action: {_ in
                genre = .romance
            }),
            OptionRow(text: "Any", isSelected: true, action: {_ in
                genre = .any
            })
        ], footer: "")
        
        genreRow.alwaysSelectsOneOption = true
        
        kindRow.alwaysSelectsOneOption = true
        
        tableContents = [
            kindRow,
            genreRow,
            Section(title: "", rows: [
                TapActionRow(text: "Start Session", action: { _ in
                    let nc = NotificationCenter.default
                    nc.post(name: NSNotification.Name(rawValue: "printValue"), object: nil, userInfo: ["type": "movie", "kind" : kind, "genre" : genre])
                    
                })
            ])
        ]
    }
    
    
}
