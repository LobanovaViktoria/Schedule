//
//  FiltersView.swift
//  TrainSchedules
//
//  Created by Viktoria Lobanova on 06.04.2024.
//

import SwiftUI

struct FiltersView: View {
    
    // MARK: - Properties
    
    @ObservedObject var viewModel: SchedulesViewModel
    @Environment(\.presentationMode) var presentationMode
    
    private let massiveTime: [String] = [
        "Утро 06:00 - 12:00",
        "День 12:00 - 18:00",
        "Вечер 18:00 - 00:00",
        "Ночь 00:00 - 06:00",
    ]
    
    private let withOrWithoutTransfers: [String] = [
        "Да",
        "Нет"
    ]
    
    // MARK: - Body
    
    var body: some View {
        ScrollView {
            navBar
                .padding(.bottom, 16)
            firstTitle
            selectionTime
            secondTitle
            withOrWithoutTransfersView
            applyButton
                .navigationBarHidden(true)
        }
    }
}

extension FiltersView {
    
    private var navBar: some View {
        CustomNavBar(
            actionForLeftButton: {
                presentationMode.wrappedValue.dismiss()
            },
            title: "")
    }
    
    private var firstTitle: some View {
        Text("Время отправления")
            .font(.system(size: 24, weight: .bold))
            .foregroundStyle(Color.black100White100)
            .frame(
                width: UIScreen.main.bounds.width - 32,
                alignment: .leading
            )
    }
    
    private var selectionTime: some View {
        ForEach(massiveTime.indices, id: \.self) { index in
            FilterCell(
                isMultipleChoice: true,
                isSelected:
                    viewModel.selectedTimeFilter.contains(
                        massiveTime[index]
                    )
                ? true
                : false,
                title: massiveTime[index],
                action: {
                    viewModel.updateSelectedTime(
                        time: massiveTime[index]
                    )
                }
            )
        }
    }
    
    private var secondTitle: some View {
        Text("Показывать варианты с пересадками")
            .font(.system(size: 24, weight: .bold))
            .foregroundStyle(Color.black100White100)
            .frame(
                width: UIScreen.main.bounds.width - 32,
                alignment: .leading
            )
    }
    
    private var withOrWithoutTransfersView: some View {
        
        ForEach(withOrWithoutTransfers.indices, id: \.self) { index in
            FilterCell(
                isMultipleChoice: false,
                isSelected:
                    viewModel.selectedTransferFilter.contains(
                        withOrWithoutTransfers[index]
                    )
                ? true
                : false,
                title: withOrWithoutTransfers[index],
                action: {
                    viewModel.updateSelectedTransfer(
                        transfer: withOrWithoutTransfers[index]
                    )
                }
            )
        }
    }
    
    private var applyButton: some View {
        CustomButton(
            title: "Применить",
            width: UIScreen.main.bounds.width - 32,
            isRedDot: false
        )
        .onTapGesture {
            presentationMode.wrappedValue.dismiss()
            
            if viewModel.selectedTimeFilter != []
                || viewModel.selectedTransferFilter != [] {
                viewModel.isApplyFilters = true
            } else {
                viewModel.isApplyFilters = false
            }
        }
    }
}

// MARK: - Preview

#Preview {
    FiltersView(
        viewModel: SchedulesViewModel(
            stories: [], cities: []
        )
    )
}
