//
//  SelectionCell.swift
//  TrainSchedules
//
//  Created by Viktoria Lobanova on 05.04.2024.
//

import SwiftUI

struct SelectionCell: View {
    
    // MARK: - Properties
    
    let action: () -> ()
    let title: String
    
    // MARK: - Init
    
    init(
        action: @escaping () -> (),
        title: String
    ) {
        self.action = action
        self.title = title
    }
    
    // MARK: - Body
    
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 17))
                .foregroundStyle(Color.black100White100)
                .padding(.leading, 16)
                .frame(width: UIScreen.main.bounds.width - 44, alignment: .leading)
            
            Button {
                action()
            } label: {
                Image(
                    systemName: "chevron.right"
                )
                .foregroundStyle(Color.black100White100)
            }
            .padding(.trailing, 16)
        }
    }
}

#Preview {
    SelectionCell(
        action: {},
        title: "Title"
    )
}
