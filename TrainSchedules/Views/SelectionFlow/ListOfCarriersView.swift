//
//  ListOfCarriers.swift
//  TrainSchedules
//
//  Created by Viktoria Lobanova on 05.04.2024.
//

import SwiftUI

struct ListOfCarriersView: View {
    
    // MARK: - Properties
    
    @ObservedObject var viewModel: SchedulesViewModel
    @Environment(\.presentationMode) var presentationMode
    
    // MARK: - Body
    
    var body: some View {
        
        ZStack {
            VStack {
                navBar
                    .padding(.top, 11)
                title
                    .padding(.top, 27)
                    .padding(.bottom, 16)
                    .padding(.horizontal, 16)
                scrollWithCarriers
            }
            
            VStack {
                Spacer()
                buttonDetail
                    .padding(.bottom, 24)
            }
            .navigationBarBackButtonHidden()
        }
    }
}

// MARK: - Extension

extension ListOfCarriersView {
    
    private var navBar: some View {
        CustomNavBar(
            actionForLeftButton: {
                presentationMode.wrappedValue.dismiss()
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
                NavigationLink {
                    CarrierDetailView()
                } label: {
                    CarrierCell()
                }
            }
        }
    }
    
    private var buttonDetail: some View {
        NavigationLink {
            FiltersView(viewModel: viewModel)
        } label: {
            CustomButton(
                title: "Уточнить время",
                width: UIScreen.main.bounds.width - 32, 
                isRedDot: viewModel.isApplyFilters ? true : false
            )
        }
    }
}

// MARK: - Preview

#Preview {
    ListOfCarriersView(viewModel: SchedulesViewModel(stories: [], cities: []))
}
