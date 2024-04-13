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
        
        Button {
            action()
        } label: {
            HStack {
                Text(title)
                    .font(.system(size: 17))
                    .foregroundStyle(Color.black100White100)
                    .padding(.leading, 16)
                    .frame(
                        maxWidth: .infinity,
                        alignment: .leading
                    )
                
                Image(systemName: "chevron.right")
                    .resizable()
                    .scaledToFit()
                    .frame(
                        width: 24,
                        height: 24
                    )
                    .foregroundStyle(Color.black100White100)
                    .padding(.trailing, 18)
            }
            .frame(height: 60)
        }
    }
}

#Preview {
    SelectionCell(
        action: {},
        title: "Title"
    )
}
