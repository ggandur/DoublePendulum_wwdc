//
//  SinglePendulumView.swift
//  DoublePendulum
//
//  Created by Gabriel Gandur on 04/04/23.
//

import Foundation
import SwiftUI

struct SinglePendulumView: View {
    @ObservedObject var globalMessages = GlobalMessages.shared
    @EnvironmentObject var appSettings: AppSettings

    @State var tapsCounter: Int = 0

    @State var angle1: Double = .pi / 1.95

    var body: some View {
        let screenWidthCenter = Double(UIScreen.main.bounds.width) / 2
        let line1: Double = 170
        let firstVertexMass: Double = 25
        let gravity: Double = 1
        var angle1Velocity: Double = 0
        var angle1Acceleration: Double = 0

        let x1: Double = line1 * sin(angle1) + screenWidthCenter
        let y1: Double = line1 * cos(angle1) + 100

        ZStack {
            BackgroundColor()
            VStack {
                ZStack {
                    // First Pendulum
                    Path { path in
                        let startingPoint = CGPoint(x: screenWidthCenter, y: 100)
                        let center1 = CGPoint(x: CGFloat(x1), y: CGFloat(y1))
                        path.move(to: startingPoint)
                        path.addLine(to: center1)
                    }
                    .stroke(Color.black, lineWidth: 2)
                    Circle()
                        .frame(width: CGFloat(firstVertexMass), height: CGFloat(firstVertexMass))
                        .foregroundColor(.blue)
                        .position(x: CGFloat(x1), y: CGFloat(y1))
                }
                .onAppear {
                    var timer: Timer?
                    timer = Timer.scheduledTimer(withTimeInterval: 0.025, repeats: true) { _ in
                        // First pendulum angles calculations
                        let force = gravity * sin(angle1)

                        angle1Acceleration = (-1 * force) / line1
                        angle1Velocity += angle1Acceleration
                        angle1 += angle1Velocity
                    }
                    if let timer = timer {
                        RunLoop.current.add(timer, forMode: .common)
                    }
                }
                DialogueView(tapsCounter: $tapsCounter,
                             message: globalMessages.messages2[tapsCounter],
                             tapsThreshold: 4,
                             messageTextColor: TextColor,
                             viewControllerDestination: 2)
            }
        }
    }
}

struct SinglePendulumView_Previews: PreviewProvider {
    static var previews: some View {
        SinglePendulumView().environmentObject(AppSettings())
    }
}
