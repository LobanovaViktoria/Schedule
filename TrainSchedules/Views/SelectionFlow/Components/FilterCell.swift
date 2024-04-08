//
//  FilterCell.swift
//  TrainSchedules
//
//  Created by Viktoria Lobanova on 06.04.2024.
//

import SwiftUI

struct FilterCell: View {
    
    // MARK: - Properties
    
    let action: () -> ()
    let title: String
    let isMultipleChoice: Bool
    let isSelected: Bool
    
    // MARK: - Init
    
    init(
        isMultipleChoice: Bool,
        isSelected: Bool,
        title: String,
        action: @escaping () -> ()
        
    ) {
        self.isMultipleChoice = isMultipleChoice
        self.isSelected = isSelected
        self.action = action
        self.title = title
    }
    
    // MARK: - Body
    
    var body: some View {
        
        Button {
            action()
        } label: {
            HStack {
                Text(title)
                    .font(.system(size: 17))
                    .foregroundStyle(Color.black100White100)
                    .frame(width: UIScreen.main.bounds.width - 60, alignment: .leading)
                
                isMultipleChoice
                ? isSelected
                     ? Image(systemName: "checkmark.square.fill")
                        .foregroundStyle(Color.black100White100)
                     : Image(systemName: "square")
                        .foregroundStyle(Color.black100White100)
                
                : isSelected
                    ? Image(systemName: "circle.circle.fill")
                        .foregroundStyle(Color.black100White100)
                    : Image(systemName: "circle")
                        .foregroundStyle(Color.black100White100)
            }
            .frame(height: 60)
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    FilterCell(
        isMultipleChoice: true,
        isSelected: false,
        title: "Title",
        action: {}
    )
}
