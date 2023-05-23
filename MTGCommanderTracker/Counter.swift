//
//  Counter.swift
//  MTGCommanderTracker
//
//  Created by MPL on 3/16/23.
//

import Foundation

struct Counter: Identifiable, Equatable {
    let id = UUID()
    var title: String
    var value: Int
}
