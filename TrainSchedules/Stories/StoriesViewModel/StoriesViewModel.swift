//
//  StoriesViewModel.swift
//  TrainSchedules
//
//  Created by Viktoria Lobanova on 28.05.2024.
//

import SwiftUI
import Combine

final class StoriesViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var state = AppState.success
    @Published var selectedStoriesIndex: Int = 0
    static var stories: [Stories] = []
    
    // MARK: - Init
    
    init() {
        getStories()
    }
    
    // MARK: - Methods
    
    private func getStories() {
        let story1 = Story(
            image: "1",
            title: "Test1 Test1",
            subTitle: "Test Test Test Test Test Test Test Test"
        )
        let story2 = Story(
            image: "2",
            title: "Test2 Test2 Test2 Test2",
            subTitle: "Test Test Test Test Test Test Test Test"
        )
        let story21 = Story(
            image: "21",
            title: "Test21 Test21 Test21 Test21",
            subTitle: "Test Test Test Test Test Test Test Test"
        )
        let story22 = Story(
            image: "22",
            title: "Test22 Test22 Test22 Test22",
            subTitle: "Test Test Test Test Test Test Test Test"
        )
        let story3 = Story(
            image: "3",
            title: "Test3 Test3 Test3 Test3 Test Test",
            subTitle: "Test Test Test Test Test Test Test Test"
        )
        let story4 = Story(
            image: "4",
            title: "Test4 Test4 Test4 Test4 Test Test Test Test",
            subTitle: "Test Test Test Test Test Test Test Test"
        )
        
        StoriesViewModel.stories = [
            Stories(items: [story1], isItShown: false),
            Stories(items: [story2, story21, story22], isItShown: false),
            Stories(items: [story3], isItShown: false),
            Stories(items: [story4], isItShown: false)
        ]
    }
}
