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
    @State var from: String = "Откуда"
    @State var to: String = "Куда"
    @State private var isTabViewHidden = false
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            
            Color.white100Black30
            
            VStack {
                scrollWithStories
                    .padding(.horizontal, 16)
                    .padding(.top, 64)
                
                fromTo
                    .frame(height: 128)
                    .padding(.top, 44)
                
                Spacer()
                
                    .navigationBarHidden(true)
            }
        }
    }
}

// MARK: - Extension MainView

extension MainView {
    
    private var scrollWithStories: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: rows, alignment: .center, spacing: 12) {
                ForEach(viewModel.stories) { story in
                    GridCellView(story: story, isNew: true)
                }
            }
            .frame(height: 144)
        }
    }
    
    private var fromTo: some View {
        ZStack {
            blueRectangle
                .padding(.horizontal, 16)
            
            HStack {
                whiteRectangle
                    .padding(.leading, 32)
                replaceView
                    .padding(.trailing, 32)
            }
        }
    }
    
    private var blueRectangle: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(Color.blueUniversal)
            .frame(
                width: UIScreen.main.bounds.width - 32,
                height: 128
            )
    }
    
    private var whiteRectangle: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(Color.whiteUniversal)
            .frame(
                width: UIScreen.main.bounds.width - 100,
                height: 96
            )
            .overlay(
                VStack(alignment: .leading, spacing: 28) {
                    NavigationLink {
                        SelectionView(typeOfSelection: .city)
                    } label: {
                        Text(from)
                            .frame(
                                width: UIScreen.main.bounds.width - 132,
                                alignment: .leading
                            )
                            .font(.system(size: 17))
                            .foregroundStyle(Color.grayUniversal)
                            .lineLimit(1)
                    }
                    
                    NavigationLink {
                        SelectionView(typeOfSelection: .station)
                    } label: {
                        Text(to)
                            .frame(
                                width: UIScreen.main.bounds.width - 132,
                                alignment: .leading
                            )
                            .font(.system(size: 17))
                            .foregroundStyle(Color.grayUniversal)
                            .lineLimit(1)
                    }
                }
            )
    }
    
    private var replaceView: some View {
        Circle()
            .fill(Color.whiteUniversal)
            .frame(width: 36)
            .overlay(
                Image(systemName: "arrow.2.squarepath")
                    .foregroundStyle(Color.blueUniversal)
                    .onTapGesture {
                        let newTo = from
                        from = to
                        to = newTo
                    }
            )
    }
}

// MARK: - Preview

#Preview {
    MainView()
}
