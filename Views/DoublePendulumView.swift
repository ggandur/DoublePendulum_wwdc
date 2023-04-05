//
//  DoublePendulumDemonstrationView.swift
//  DoublePendulum
//
//  Created by Gabriel Gandur on 30/03/23.
//

import Foundation
import SwiftUI

struct DoublePendulumView: View {
    @ObservedObject var globalMessages = GlobalMessages.shared
    @EnvironmentObject var appSettings: AppSettings

    @State var isSimulationStarted: Bool = false

    @State var angle1: Double = .pi / 1.95
    @State var angle2: Double = .pi / 1.85
    @State var angle3: Double = .pi / 1.88
    @State var angle4: Double = .pi / 1.78

    @State var angle1Velocity: Double = 0
    @State var angle2Velocity: Double = 0
    @State var angle3Velocity: Double = 0
    @State var angle4Velocity: Double = 0

    @State var angle1Acceleration: Double = 0
    @State var angle2Acceleration: Double = 0
    @State var angle3Acceleration: Double = 0
    @State var angle4Acceleration: Double = 0

    @State var buttonText: String = "Start Simulation"
    @State var tapsCounter: Int = 0

    var body: some View {
        let screenWidthCenter = Double(UIScreen.main.bounds.width) / 2
        let line1: Double = 170
        let line2: Double = 170
        let firstVertexMass: Double = 25
        let secondVertexMass: Double = 25
        let gravity = 0.1
        let startingX: Double = 300

        let x1: Double = line1 * sin(angle1) + screenWidthCenter
        let y1: Double = line1 * cos(angle1) + startingX
        let x2: Double = x1 + (line2 * sin(angle2))
        let y2: Double = y1 + (line2 * cos(angle2))

        let firstVertexMass2: Double = 25
        let secondVertexMass2: Double = 25

        let x1b: Double = line1 * sin(angle3) + screenWidthCenter
        let y1b: Double = line1 * cos(angle3) + startingX
        let x2b: Double = x1b + (line2 * sin(angle4))
        let y2b: Double = y1b + (line2 * cos(angle4))

        ZStack {
            BackgroundColor()
            if tapsCounter < 2 {
                Color(red: 0, green: 0, blue: 0, opacity: 0.7)
                    .ignoresSafeArea()
            }
            VStack {
                ZStack {
                    // First Pendulum
                    Path { path in
                        let startingPoint = CGPoint(x: screenWidthCenter, y: startingX)
                        let center1 = CGPoint(x: CGFloat(x1b), y: CGFloat(y1b))
                        let center2 = CGPoint(x: CGFloat(x2b), y: CGFloat(y2b))
                        path.move(to: startingPoint)
                        path.addLine(to: center1)
                        path.move(to: center1)
                        path.addLine(to: center2)
                    }
                    .stroke(Color.black, lineWidth: 2)
                    Circle()
                        .frame(width: CGFloat(firstVertexMass2), height: CGFloat(firstVertexMass2))
                        .foregroundColor(.red)
                        .position(x: CGFloat(x1b), y: CGFloat(y1b))
                    Circle()
                        .frame(width: CGFloat(secondVertexMass2), height: CGFloat(secondVertexMass2))
                        .foregroundColor(.red)
                        .position(x: CGFloat(x2b), y: CGFloat(y2b))

                    // Second Pendulum
                    Path { path in
                        let startingPoint = CGPoint(x: screenWidthCenter, y: startingX)
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
                    if tapsCounter >= 2 {
                        VStack {
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
                                    Text("Reset Angles")
                                        .fontWeight(.bold)
                                        .font(.system(size: 24))
                                        .padding()
                                        .background(Color.purple.opacity(0.8))
                                        .foregroundColor(Color.white)
                                        .cornerRadius(10)
                                        .padding(.leading, 50)
                                })
                                Spacer()
                                    .frame(width: 250)
                                Button(action: {
                                    isSimulationStarted.toggle()
                                    if isSimulationStarted {
                                        buttonText = "Pause Simulation"
                                    } else {
                                        buttonText = "Resume Simulation"
                                    }
                                }, label: {
                                    Text("\(buttonText)")
                                        .fontWeight(.bold)
                                        .font(.system(size: 24))
                                        .padding()
                                        .background(Color.purple.opacity(0.8))
                                        .foregroundColor(Color.white)
                                        .cornerRadius(10)
                                        .padding(.trailing, 50)
                                })
                                .frame(width: 300)
                            }
                            .padding(.top, 20)
                            Spacer()
                            Image("Professora")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 300)
                                .padding(.bottom, 20)
                            HStack {
                                Spacer()
                                NextButton(tapsCounter: $tapsCounter,
                                           viewControllerDestination: 3)
                            }
                        }
                    }
                }
                .onAppear {
                    let timer = Timer.scheduledTimer(withTimeInterval: 0.025, repeats: true) { _ in
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

                        // Second pendulum angles calculations
                        var num5: Double = -gravity * (2 * firstVertexMass2 * secondVertexMass2) * sin(angle3)
                        var num6: Double = -secondVertexMass2 * gravity * sin(angle3 - 2 * angle4)
                        var num7: Double = -2 * sin(angle3 - angle4) * secondVertexMass2
                        var num8: Double = angle4Velocity * angle4Velocity * line2 + angle3Velocity * angle3Velocity * line1 * cos(angle3 - angle4)
                        var denominator2: Double = line1 * (2 * firstVertexMass2 + secondVertexMass2 - secondVertexMass2 * cos(2 * angle3 - 2 * angle4))
                        angle3Acceleration = (num5 + num6 + num7 * num8) / denominator2

                        num5 = 2 * sin(angle3 - angle4)
                        num6 = (angle3Velocity * angle3Velocity * line1 * (firstVertexMass2 + secondVertexMass2))
                        num7 = gravity * (firstVertexMass2 + secondVertexMass2) * cos(angle3)
                        num8 = angle4Velocity * angle4Velocity * line2 * secondVertexMass2 * cos(angle3 - angle4)
                        denominator2 = line2 * (2 * firstVertexMass2 + secondVertexMass2 - secondVertexMass2 * cos(2 * angle3 - 2 * angle4))
                        angle4Acceleration = (num5 * (num6 + num7 + num8)) / denominator2

                        if isSimulationStarted {
                            // First pendulum angles
                            angle1Velocity += angle1Acceleration
                            angle1 += angle1Velocity
                            angle2Velocity += angle2Acceleration
                            angle2 += angle2Velocity

                            // Second pendulum angles
                            angle3Velocity += angle3Acceleration
                            angle3 += angle3Velocity
                            angle4Velocity += angle4Acceleration
                            angle4 += angle4Velocity
                        }
                    }
                    RunLoop.current.add(timer, forMode: .common)
                }
            }
            if tapsCounter < 2 {
                VStack {
                    Spacer()
                        .frame(height: 400)
                    DialogueView(tapsCounter: $tapsCounter,
                                 message: globalMessages.messages4[tapsCounter],
                                 messageTextColor: InfoColor,
                                 viewControllerDestination: 3)
                }
            }
        }
    }
}

struct DoublePendulumView_Previews: PreviewProvider {
    static var previews: some View {
        DoublePendulumView().environmentObject(AppSettings())
    }
}
