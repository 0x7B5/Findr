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
