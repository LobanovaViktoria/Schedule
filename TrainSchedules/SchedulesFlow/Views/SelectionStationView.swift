//
//  SelectionStationView.swift
//  TrainSchedules
//
//  Created by Viktoria Lobanova on 05.04.2024.
//

import SwiftUI

struct SelectionStationView: View {
    
    // MARK: - Properties
    
    var typeOfFromTo: TypeOfFromTo
    
    @State private var searchString = ""
    @Binding var showingSelectionStation: Bool
   
    @ObservedObject var viewModel: SchedulesViewModel
    
    var searchResultStation: [Station] {
        if searchString.isEmpty {
            return viewModel.selectedCityFrom?.stations ?? []
        } else {
            return viewModel.selectedCityFrom?.stations.filter {
                $0.name.lowercased().contains(searchString.lowercased())
            } ?? []
        }
    }
    
    
    // MARK: - Body
    
    var body: some View {
        
        ZStack {
            
            if searchResultStation == [] {
                Text("Станция не найдена")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(Color.black100White100)
            }
            
            VStack {
                CustomNavBar(
                    actionForLeftButton: {
                        viewModel.path.removeLast()
                        showingSelectionStation = false
                    },
                    title: "Выбор станции"
                )
                .padding(.top, 11)
                
                SearchBar(searchText: $searchString)
                
                LazyVStack {
                    
                    switch typeOfFromTo {
                    case .from:
                        ForEach(searchResultStation) { station in
                            SelectionCell(
                                action: {
                                    
                                    viewModel.selectedStationFrom = station
                                    viewModel.getTitleForListOfCarriers()
                                    showingSelectionStation = false
                                    for _ in 0..<viewModel.path.count {
                                        viewModel.path.removeLast()
                                    }
                                },
                                title: station.name
                            )
                            
                        }
                    case .to:
                        ForEach(searchResultStation) { station in
                            SelectionCell(
                                action: {
                                   
                                    viewModel.selectedStationTo = station
                                    viewModel.getTitleForListOfCarriers()
                                    showingSelectionStation = false
                                    for _ in 0..<viewModel.path.count {
                                        viewModel.path.removeLast()
                                    }
                                   // presentationMode.wrappedValue.dismiss()
                                },
                                title: station.name
                            )
                        }
                    }
                }
                Spacer()
            }
            .navigationBarHidden(true)
        }
    }
}