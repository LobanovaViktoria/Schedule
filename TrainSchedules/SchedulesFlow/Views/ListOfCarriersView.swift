//
//  ListOfCarriers.swift
//  TrainSchedules
//
//  Created by Viktoria Lobanova on 05.04.2024.
//

import SwiftUI

struct ListOfCarriersView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject var coordinator: BaseCoordinator
    @EnvironmentObject var viewModel: SchedulesViewModel
    
    // MARK: - Body
    
    var body: some View {
        switch viewModel.state {
        case .failed(let error):
            ErrorView(error: error)
        case .success:
            successView
        }
    }
}

// MARK: - Extension

extension ListOfCarriersView {
    
    private var successView: some View {
        ZStack {
            VStack {
                navBar
                    .padding(.top, 11)
                title
                    .padding(.top, 27)
                    .padding(.bottom, 16)
                    .padding(.horizontal, 16)
                scrollWithCarriers
                    .padding(.bottom, 0)
                buttonDetail
                    .padding(.bottom, 24)
            }
            .toolbar(.hidden, for: .navigationBar, .tabBar)
        }
    }
    
    private var navBar: some View {
        CustomNavBar(
            actionForLeftButton: {
                coordinator.removeLast()
            },
            title: "")
    }
    
    private var title: some View {
        Text(viewModel.titleForListOfCarriers)
            .font(.system(size: 24, weight: .bold))
            .foregroundStyle(Color.black100White100)
            .frame(
                width: UIScreen.main.bounds.width - 32,
                alignment: .leading
            )
            .multilineTextAlignment(.leading)
    }
    
    private var scrollWithCarriers: some View {
        ScrollView (.vertical, showsIndicators: false) {
            ForEach(1..<10) { _ in
                    CarrierCell()
                        .padding(.horizontal, 16)
                        .onTapGesture {
                            coordinator.carrierDetail()
                        }
            }
        }
    }
    
    private var buttonDetail: some View {
        Button {
            coordinator.filters()
        } label: {
            CustomButton(
                title: "Уточнить время",
                isRedDot: viewModel.isApplyFilters ? true : false
            )
            .padding(.horizontal, 16)
        }
    }
}

// MARK: - Preview

#Preview {
    ListOfCarriersView()
}
