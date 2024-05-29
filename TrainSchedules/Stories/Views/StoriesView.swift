//
//  StoriesView.swift
//  TrainSchedules
//
//  Created by Viktoria Lobanova on 23.05.2024.
//

import SwiftUI

struct StoriesView: View {
   
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var storiesViewModel: StoriesViewModel
 
    var body: some View {
        switch storiesViewModel.state {
        case .failed(let error):
            ErrorView(error: error)
        case .success:
            successView
        }
    }
}

// MARK: Extension StoriesView

extension StoriesView {
    private var successView: some View {
        Color.blackUniversal
            .ignoresSafeArea()
            .overlay {
                TabView(selection: $storiesViewModel.selectedStoriesIndex) {
                    ForEach(0..<storiesViewModel.stories.count, id: \.self) { index in
                        TabStoriesView(stories: storiesViewModel.stories[storiesViewModel.selectedStoriesIndex].items, actionForFinishStories: {
                            if index == storiesViewModel.stories.count - 1 {
                                storiesViewModel.stories[index].isItShown = true
                                storiesViewModel.selectedStoriesIndex = index
                                closeView()
                            } else {
                                storiesViewModel.selectedStoriesIndex = index + 1
                                storiesViewModel.stories[index].isItShown = true
                            }
                           
                        }, actionForCloseButton: {
                            storiesViewModel.stories[index].isItShown = true
                            closeView()
                        })
                    }
                }
                .ignoresSafeArea()
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    
            }
        }
    
    private func closeView() {
        presentationMode.wrappedValue.dismiss()
    }
    
    private var closeButton: some View {
        HStack {
            Spacer()
            Button(action: {
              presentationMode.wrappedValue.dismiss()
            }, label: {
                Image("closeButton")
                    .resizable()
                    .frame(width: 30, height: 30)
            }
            )
            .padding(.top, 50)
            .padding(.trailing, 12)
        }
    }
}

// MARK: Preview

#Preview {
    StoriesView()
}
