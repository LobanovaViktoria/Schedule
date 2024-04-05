//
//  SelectionView.swift
//  TrainSchedules
//
//  Created by Viktoria Lobanova on 04.04.2024.
//

import SwiftUI

// MARK: - Enum TypeOfSelection

enum TypeOfSelection {
    case city
    case station
    
    var navBarTitle: String {
        switch self {
        case .city:
            "Выбор города"
        case .station:
            "Выбор станции"
        }
    }
}

struct SelectionView: View {
    
    // MARK: - Properties
    
    var typeOfSelection: TypeOfSelection
    @State private var searchString = ""
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: SchedulesViewModel
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            CustomNavBar(
                actionForLeftButton: {
                    dismiss()
                },
                title: typeOfSelection.navBarTitle
            )
            .padding(.top, 11)
            
            SearchBar(searchText: $searchString)
            
            LazyVStack {
                
            }
                .navigationBarBackButtonHidden()
        }
    }
}

// MARK: - Preview

#Preview {
    SelectionView(typeOfSelection: .city)
}
