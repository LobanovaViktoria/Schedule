//
//  CustomNavBar.swift
//  TrainSchedules
//
//  Created by Viktoria Lobanova on 05.04.2024.
//

import SwiftUI

struct CustomNavBar: View {
    
    // MARK: - Properties
    
    let actionForLeftButton: () -> ()
    let title: String
    
    // MARK: - Init
    
    init(
        actionForLeftButton: @escaping () -> (),
        title: String
    ) {
        self.actionForLeftButton = actionForLeftButton
        self.title = title
    }
      
    // MARK: - Body
    
    var body: some View {
        HStack {
            Button {
                actionForLeftButton()
            } label: {
                Image(
                    systemName: "chevron.backward"
                )
                .foregroundStyle(Color.black100White100)
            }
            .padding(.leading, 8)
            
            Text(title)
                .foregroundStyle(Color.black100White100)
                .font(.system(size: 17, weight: .bold))
                .frame(
                    width: UIScreen.main.bounds.width - 72, 
                    alignment: .center
                )
                .padding(.trailing, 36)
        }
    }
}
