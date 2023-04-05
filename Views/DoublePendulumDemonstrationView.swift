//
//  DoublePendulumDemonstrationView.swift
//  DoublePendulum
//
//  Created by Gabriel Gandur on 01/04/23.
//

import Foundation
import SwiftUI

struct DoublePendulumDemonstrationView: View {
    @ObservedObject var globalMessages = GlobalMessages.shared
    @EnvironmentObject var appSettings: AppSettings

    @State var tapsCounter: Int = 0

    @State var angle1: Double = .pi / 1.88
    @State var angle2: Double = .pi / 1.78

    var body: some View {
        let screenWidthCenter = Double(UIScreen.main.bounds.width) / 2
        let line1: Double = 170
        let line2: Double = 170
        let firstVertexMass: Double = 25
        let secondVertexMass: Double = 25
        let gravity = 0.1
        var angle2Velocity: Double = 0
        var angle1Velocity: Double = 0
        var angle2Acceleration: Double = 0
        var angle1Acceleration: Double = 0

        let x1: Double = line1 * sin(angle1) + screenWidthCenter
        let y1: Double = line1 * cos(angle1) + 150
        let x2: Double = x1 + (line2 * sin(angle2))
        let y2: Double = y1 + (line2 * cos(angle2))

        ZStack {
            BackgroundColor()
            VStack {
                ZStack {
                    // First Pendulum
                    Path { path in
                        let startingPoint = CGPoint(x: screenWidthCenter, y: 150)
                        let center1 = CGPoint(x: CGFloat(x1), y: CGFloat(y1))
                        let center2 = CGPoint(x: CGFloat(x2), y: CGFloat(y2))
                        path.move(to: startingPoint)
                        path.addLine(to: center1)
                        path.move(to: center1)
                        path.addLine(to: center2)
                    }
                    .stroke(Color.black, lineWidth: 2)
                    Circle()
                        .frame(width: CGFloat(firstVertexMass), height: CGFloat(firstVertexMass))
                        .foregroundColor(.blue)
                        .position(x: CGFloat(x1), y: CGFloat(y1))
                    Circle()
                        .frame(width: CGFloat(secondVertexMass), height: CGFloat(secondVertexMass))
                        .foregroundColor(.blue)
                        .position(x: CGFloat(x2), y: CGFloat(y2))
                }
                .onAppear {
                    var timer: Timer?
                    timer = Timer.scheduledTimer(withTimeInterval: 0.025, repeats: true) { _ in
                        // First pendulum angles calculations
                        var num1: Double = -gravity * (2 * firstVertexMass * secondVertexMass) * sin(angle1)
                        var num2: Double = -secondVertexMass * gravity * sin(angle1 - 2 * angle2)
                        var num3: Double = -2 * sin(angle1 - angle2) * secondVertexMass
                        var num4: Double = angle2Velocity * angle2Velocity * line2 + angle1Velocity * angle1Velocity * line1 * cos(angle1 - angle2)
                        var denominator: Double = line1 * (2 * firstVertexMass + secondVertexMass - secondVertexMass * cos(2 * angle1 - 2 * angle2))
                        angle1Acceleration = (num1 + num2 + num3 * num4) / denominator

                        num1 = 2 * sin(angle1 - angle2)
                        num2 = (angle1Velocity * angle1Velocity * line1 * (firstVertexMass + secondVertexMass))
                        num3 = gravity * (firstVertexMass + secondVertexMass) * cos(angle1)
                        num4 = angle2Velocity * angle2Velocity * line2 * secondVertexMass * cos(angle1 - angle2)
                        denominator = line2 * (2 * firstVertexMass + secondVertexMass - secondVertexMass * cos(2 * angle1 - 2 * angle2))
                        angle2Acceleration = (num1 * (num2 + num3 + num4)) / denominator

                        // First pendulum angles
                        angle1Velocity += angle1Acceleration
                        angle1 += angle1Velocity
                        angle2Velocity += angle2Acceleration
                        angle2 += angle2Velocity
                    }
                    if let timer = timer {
                        RunLoop.current.add(timer, forMode: .common)
                    }
                }
                DialogueView(tapsCounter: $tapsCounter,
                             message: globalMessages.messages3[tapsCounter],
                             tapsThreshold: 4,
                             messageTextColor: TextColor,
                             viewControllerDestination: 3)
            }
        }
    }
}

struct DoublePendulumDemonstrationView_Previews: PreviewProvider {
    static var previews: some View {
        DoublePendulumDemonstrationView().environmentObject(AppSettings())
    }
}
