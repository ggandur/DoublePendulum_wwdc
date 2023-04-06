//
//  SwiftUIView.swift
//
//
//  Created by Gabriel Gandur on 06/04/23.
//

import Foundation
import SwiftUI

struct HeaderControls: View {
    @Binding var angle1: Double
    @Binding var angle2: Double
    @Binding var angle3: Double
    @Binding var angle4: Double

    @Binding var angle1Velocity: Double
    @Binding var angle2Velocity: Double
    @Binding var angle3Velocity: Double
    @Binding var angle4Velocity: Double

    @Binding var angle1Acceleration: Double
    @Binding var angle2Acceleration: Double
    @Binding var angle3Acceleration: Double
    @Binding var angle4Acceleration: Double

    @Binding var isSimulationStarted: Bool
    @Binding var toggleNext: Bool
    @Binding var buttonName: String

    var body: some View {
        HStack {
            Button(action: {
                angle1 = .pi / 1.95
                angle2 = .pi / 1.85
                angle3 = .pi / 1.88
                angle4 = .pi / 1.78

                angle1Velocity = 0.0
                angle2Velocity = 0.0
                angle3Velocity = 0.0
                angle4Velocity = 0.0

                angle1Acceleration = 0.0
                angle2Acceleration = 0.0
                angle3Acceleration = 0.0
                angle4Acceleration = 0.0
            }, label: {
                Image(systemName: "arrow.clockwise.circle.fill")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .foregroundColor(Color.purple.opacity(0.8))
            })
            Spacer()
            Button(action: {
                isSimulationStarted.toggle()
                toggleNext = true
                if isSimulationStarted {
                    buttonName = "pause.circle.fill"
                } else {
                    buttonName = "play.circle.fill"
                }
            }, label: {
                Image(systemName: "\(buttonName)")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .foregroundColor(Color.purple.opacity(0.8))
            })
        }
        .frame(width: 650)
        .padding(.top, 40)
    }
}
