//
//  TimerConfiguration.swift
//  TrainSchedules
//
//  Created by Viktoria Lobanova on 29.05.2024.
//

import SwiftUI

struct TimerConfiguration {
    
    // MARK: - Properties
    
    let timerTickInternal: TimeInterval
    let progressPerTick: CGFloat
    
    // MARK: - Init
    
    init(
        storiesCount: Int,
        secondsPerStory: TimeInterval = 5,
        timerTickInternal: TimeInterval = 0.25
    ) {
        self.timerTickInternal = timerTickInternal
        self.progressPerTick = 1.0 / CGFloat(storiesCount) / secondsPerStory * timerTickInternal
    }
}
