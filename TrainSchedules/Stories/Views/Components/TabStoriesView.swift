//
//  StoriesTabView.swift
//  TrainSchedules
//
//  Created by Viktoria Lobanova on 23.05.2024.
//

import SwiftUI
import Combine

struct TabStoriesView: View {
    struct Configuration {
        let timerTickInternal: TimeInterval
        let progressPerTick: CGFloat
        
        init(
            storiesCount: Int,
            secondsPerStory: TimeInterval = 5,
            timerTickInternal: TimeInterval = 0.25
        ) {
            self.timerTickInternal = timerTickInternal
            self.progressPerTick = 1.0 / CGFloat(storiesCount) / secondsPerStory * timerTickInternal
        }
    }
    
    let stories: [Story]
    
    private let configuration: Configuration
    private var currentStory: Story { stories[currentStoryIndex] }
    private var currentStoryIndex: Int { Int(progress * CGFloat(stories.count)) }
    @State private var progress: CGFloat = 0
    @State private var timer: Timer.TimerPublisher
    @State private var cancellable: Cancellable?
    let actionForFinishStories: () -> ()
    let actionForCloseButton: () -> ()
    
    init(stories: [Story],
         actionForFinishStories: @escaping () -> (),
         actionForCloseButton: @escaping () -> ()
    ) {
        self.stories = stories
        configuration = Configuration(storiesCount: stories.count)
        timer = Self.createTimer(configuration: configuration)
        self.actionForFinishStories = actionForFinishStories
        self.actionForCloseButton = actionForCloseButton
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            StoryView(story: currentStory)
            ProgressBar(numberOfSections: stories.count, progress: progress)
                .padding(.init(top: 28, leading: 12, bottom: 12, trailing: 12))
            CloseButton(action: {
                actionForCloseButton()
            }
            )
            .padding(.top, 57)
            .padding(.trailing, 12)
        }
        .onAppear {
            timer = Self.createTimer(configuration: configuration)
            cancellable = timer.connect()
        }
        .onDisappear {
            cancellable?.cancel()
        }
        .onReceive(timer) { _ in
            timerTick()
        }
        .onTapGesture {
            if stories.count > 1 && currentStoryIndex < stories.count - 1 {
                nextStory()
                resetTimer()
            }
        }
    }
    private func timerTick() {
        var nextProgress = progress + configuration.progressPerTick
        if nextProgress >= 1 {
            nextProgress = 0
            actionForFinishStories()
        }
        withAnimation {
            progress = nextProgress
        }
    }
    
    private func nextStory() {
        let storiesCount = stories.count
        let currentStoryIndex = Int(progress * CGFloat(storiesCount))
        let nextStoryIndex = currentStoryIndex + 1 < storiesCount ? currentStoryIndex + 1 : 0
        withAnimation {
            progress = CGFloat(nextStoryIndex) / CGFloat(storiesCount)
        }
    }
    
    private func resetTimer() {
        cancellable?.cancel()
        timer = Self.createTimer(configuration: configuration)
        cancellable = timer.connect()
    }
    
    private static func createTimer(
        configuration: Configuration
    ) -> Timer.TimerPublisher {
        Timer.publish(
            every: configuration.timerTickInternal,
            on: .main,
            in: .common
        )
    }
}
