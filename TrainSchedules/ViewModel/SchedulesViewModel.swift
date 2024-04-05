//
//  SchedulesViewModel.swift
//  TrainSchedules
//
//  Created by Viktoria Lobanova on 04.04.2024.
//

import Foundation

class SchedulesViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var stories: [Story]
    @Published var stations:
    
    // MARK: - Init
    
    init(stories: [Story]) {
        self.stories = stories
        getStories()
    }

    // MARK: - Methods
    
    private func getStories() {
        let story1 = Story(
            images: ["1"],
            title: "Test Test",
            subTitle: "Test Test Test Test Test Test Test Test"
        )
        let story2 = Story(
            images: ["2", "21", "22"],
            title: "Test Test Test Test",
            subTitle: "Test Test Test Test Test Test Test Test"
        )
        let story3 = Story(
            images: ["3"],
            title: "Test Test Test Test Test Test",
            subTitle: "Test Test Test Test Test Test Test Test"
        )
        let story4 = Story(
            images: ["4"],
            title: "Test Test Test Test Test Test Test Test",
            subTitle: "Test Test Test Test Test Test Test Test")
        
        self.stories = [story1, story2, story3, story4]
    }
}
