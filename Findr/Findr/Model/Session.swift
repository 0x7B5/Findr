//
//  Session.swift
//  Findr
//
//  Created by Vlad Munteanu on 9/18/20.
//

import Foundation
import Firebase

let db = Firestore.firestore()

enum sessionType {
    case food, movie
}

public struct Session {
    let User1: String
    let User2: String
    let type: sessionType
    let key: String
}

public struct FoodSession {
    let User1: String
    let User2: String
    let priceRange: PriceRange
    let minRating: MinRating
    let key: String
    var foods: [Food]
}

public struct MovieSession {
    let User1: String
    let User2: String
    let kind: movieKind
    let genre: movieGenre
    let key: String
    let movies: [Movie]
}

enum MinRating: String {
    case five, four, three, any
}

enum PriceRange: String {
    case three, two, one, any
}

enum movieKind: String {
    case movie, tvshow, both
}

enum movieGenre: String {
    case comedy, action, horror, romance, any
}
