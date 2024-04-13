//
//  SelectionView.swift
//  TrainSchedules
//
//  Created by Viktoria Lobanova on 04.04.2024.
//

import SwiftUI

// MARK: - Enum

enum TypeOfFromTo {
    case from
    case to
}

struct SelectionCityView: View {
    
    // MARK: - Properties
    
    var typeOfFromTo: TypeOfFromTo
        
    @State private var searchString = ""
    @State private var selectedCity: City? = nil
    
    @EnvironmentObject var coordinator: BaseCoordinator
    @EnvironmentObject var viewModel: SchedulesViewModel
    @Environment(\.dismiss) private var dismiss
    
    var searchResultCity: [City] {
        if searchString.isEmpty {
            return viewModel.cities
        } else {
            return viewModel.cities.filter {
                $0.name.lowercased().contains(searchString.lowercased())
            }
        }
    }
   
    // MARK: - Body
    
    var body: some View {
        
        ZStack {
            if searchResultCity == [] {
                Text("Город не найден")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(Color.black100White100)
            }
            
            VStack {
                CustomNavBar(
                    actionForLeftButton: {
                        dismiss()
                    },
                    title: "Выбор города"
                )
                .padding(.top, 11)
                
                SearchBar(searchText: $searchString)
                
                LazyVStack {
                    
                    switch typeOfFromTo {
                        
                    case .from:
                        
                        ForEach(searchResultCity) { city in
                            SelectionCell(
                                action: {
                                    viewModel.selectedCityFrom = city
                                    coordinator.selectingStationFrom()
                                },
                                title: city.name
                            )
                        }
                    case .to:
                        
                        ForEach(searchResultCity) { city in
                            SelectionCell(
                                action: {
                                    viewModel.selectedCityTo = city
                                    coordinator.selectingStationTo()
                                },
                                title: city.name
                            )
                        }
                    }
                }
                Spacer()
            }
            .toolbar(.hidden, for: .navigationBar)
        }
    }
}
