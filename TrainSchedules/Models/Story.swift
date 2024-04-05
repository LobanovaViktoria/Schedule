//
//  Stories.swift
//  TrainSchedules
//
//  Created by Viktoria Lobanova on 04.04.2024.
//

import Foundation

struct Story: Hashable, Identifiable {
    var id = UUID()
    var images: [String]
    var text: String
}
