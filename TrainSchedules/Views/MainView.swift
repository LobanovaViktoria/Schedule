//
//  StationSelectionView.swift
//  TrainSchedules
//
//  Created by Viktoria Lobanova on 03.04.2024.
//

import SwiftUI

struct MainView: View {
    
    // MARK: - Properties
   
    @StateObject var viewModel = SchedulesViewModel(stories: [])
    private let rows = [GridItem()]
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            Color.white100Black30
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: rows, alignment: .center, spacing: 12) {
                        ForEach(viewModel.stories) { story in
                            GridCellView(story: story, isNew: true)
                        }
                    }
                    .frame(height: 140)
                    .padding(.horizontal, 16)
                    .padding(.top, 64)
                }
               
                FromToView()
                    .padding(.top, 44)
                Spacer()
            }
        }
    }
}

// MARK: - Preview

#Preview {
    MainView()
}
