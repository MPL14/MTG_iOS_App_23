//
//  Counter.swift
//  MTGCommanderTracker
//
//  Created by MPL on 3/16/23.
//

// This would be in Counter.swift

import Foundation

struct Counter: Codable, Identifiable {
    var id = UUID()
    var title: String
    var value: Int
}
