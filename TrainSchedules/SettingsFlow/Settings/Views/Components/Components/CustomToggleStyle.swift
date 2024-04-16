//
//  CustomToggleStyle.swift
//  TrainSchedules
//
//  Created by Viktoria Lobanova on 13.04.2024.
//

import SwiftUI

struct CustomToggleStyle: ToggleStyle {
    
    var colorIsOn: Color
    var colorIsOff: Color
    
    func makeBody(configuration: Configuration) -> some View {
        Toggle("", isOn: configuration.$isOn)
            .labelsHidden()
            .background(
                configuration.isOn
                ? colorIsOn
                : colorIsOff
            )
            .clipShape(Capsule())
    }
}

