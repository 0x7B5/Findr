//
//  Session.swift
//  Findr
//
//  Created by Vlad Munteanu on 9/18/20.
//

import Foundation

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
}

public struct MovieSession {
    let User1: String
    let User2: String
    let kind: movieKind
    let genre: movieGenre
    let key: String
}

enum MinRating {
    case five, four, three, any
}

enum PriceRange {
    case three, two, one, any
}

enum movieKind {
    case movie, tvshow, both
}

enum movieGenre {
    case comedy, action, horror, romance, any
}
