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

    let teacherImages = ["ProfessoraEnsinando", "ProfessoraFalando", "ProfessoraLuz", "ProfessoraConvencida"]

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
                    Pendulum(color: Color.blue,
                             startingX: 150,
                             x1: x1,
                             y1: y1,
                             x2: x2,
                             y2: y2)
                }
                .onAppear {
                    var timer: Timer?
                    timer = Timer.scheduledTimer(withTimeInterval: 0.025, repeats: true) { _ in
                        // First pendulum angles calculations
                        (angle1Acceleration,
                         angle2Acceleration) = calculateAngles(gravity: gravity,
                                                               firstVertexMass: firstVertexMass,
                                                               secondVertexMass: secondVertexMass,
                                                               angle1: angle1,
                                                               angle2: angle2,
                                                               angle1Velocity: angle1Velocity,
                                                               angle2Velocity: angle2Velocity,
                                                               line1: line1,
                                                               line2: line2)

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
                             viewControllerDestination: 3, images: teacherImages)
            }
        }
    }
}

struct DoublePendulumDemonstrationView_Previews: PreviewProvider {
    static var previews: some View {
        DoublePendulumDemonstrationView().environmentObject(AppSettings())
    }
}
