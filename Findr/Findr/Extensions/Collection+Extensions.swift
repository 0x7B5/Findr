//
//  File.swift
//  Findr
//
//  Created by Vlad Munteanu on 9/19/20.
//

import Foundation

extension Collection {
    func choose(_ n: Int) -> ArraySlice<Element> { shuffled().prefix(n) }
}
