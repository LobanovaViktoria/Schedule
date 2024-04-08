//
//  CarrierCell.swift
//  TrainSchedules
//
//  Created by Viktoria Lobanova on 05.04.2024.
//

import SwiftUI

struct CarrierCell: View {
    
    var body: some View {
        
        RoundedRectangle(cornerRadius: 24)
            .fill(Color.lightGrayUniversal)
            .frame(
                width: UIScreen.main.bounds.width - 32,
                height: 104
            )
            .overlay {
                VStack {
                    HStack {
                        Image("brandIcon")
                            .resizable()
                            .scaledToFit()
                            .frame(
                                width: 38,
                                height: 38
                            )
                            .padding(.trailing, 8)
                            .padding(.leading, 30)
                        VStack {
                            Text("РЖД")
                                .font(.system(size: 17))
                                .foregroundStyle(Color.blackUniversal)
                                .frame(
                                    width: UIScreen.main.bounds.width - 185,
                                    alignment: .leading
                                )
                            Text("С пересадкой в Костроме")
                                .font(.system(size: 12))
                                .foregroundStyle(Color.redUniversal)
                                .frame(
                                    width: UIScreen.main.bounds.width - 185,
                                    alignment: .leading
                                )
                        }
                        .padding(.trailing, 4)
                        
                        Text("14 января")
                            .font(.system(size: 12))
                            .foregroundStyle(Color.blackUniversal)
                            .frame(width: 65, alignment: .trailing)
                            .padding(.trailing, 30)
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 18)
                    
                    HStack {
                        Text("22:30")
                            .font(.system(size: 17))
                            .foregroundStyle(Color.blackUniversal)
                        VStack {
                            Divider()
                        }
                        Text("20 часов")
                            .font(.system(size: 12))
                            .foregroundStyle(Color.blackUniversal)
                        VStack {
                            Divider()
                        }
                        Text("08:15")
                            .font(.system(size: 17))
                            .foregroundStyle(Color.blackUniversal)
                    }
                    .padding(.horizontal, 14)
                }
            }
    }
}

#Preview {
    CarrierCell()
}
