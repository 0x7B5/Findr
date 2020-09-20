//
//  Movie.swift
//  Findr
//
//  Created by Vlad Munteanu on 9/18/20.
//

import Foundation
import UIKit
public struct Movie {
    let title: String
    #warning("Figure out the handle this shit")
    let image: String
    let id: String
    let genre: [Int]
    let description: String
    let imdbScore: Float
    let trailerLink: String
    let user1Swiped: Bool = false
    let user2Swiped: Bool = false
}
