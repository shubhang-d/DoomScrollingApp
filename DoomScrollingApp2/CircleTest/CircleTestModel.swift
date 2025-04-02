//
//  CircleTestModel.swift
//  doomScrolling
//
//  Created by Shubhang Dixit on 22/02/25.
//

import SwiftData
import Foundation

@Model
class CircleTestModel{
    var dateTime: Date = Date()
    var tapPercentage: Float
    var averageReactionTime: String
    init(dateTime: Date, tapPercentage: Float, averageReactionTime: String) {
        self.dateTime = dateTime
        self.tapPercentage = tapPercentage
        self.averageReactionTime = averageReactionTime
    }
}
