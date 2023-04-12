//
//  SwiftUIView.swift
//
//
//  Created by Gabriel Gandur on 09/04/23.
//

import Foundation
import SwiftUI

struct HomeView: View {
    @EnvironmentObject var appSettings: AppSettings

    @State var tapsCounter: Int = 0
    @State var angle1: Double = .pi / 8

    let teacherImages = ["ProfessoraEnsinando", "ProfessoraNormal", "ProfessoraFalando", "ProfessoraConvencida"]

    var body: some View {
        let screenWidthCenter = Double(UIScreen.main.bounds.width) / 2
        let line1: Double = 400
        let gravity: Double = 1
        var angle1Velocity: Double = 0
        var angle1Acceleration: Double = 0

        let x1: Double = line1 * sin(angle1) + screenWidthCenter
        let y1: Double = line1 * cos(angle1)

        ZStack {
            BackgroundColor()
            VStack {
                Text("Penduleer")
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 92))
                    .foregroundColor(TextColor)
                    .frame(width: 700, height: 300, alignment: .center)
                ZStack {
                    // First Pendulum
                    Path { path in
                        let startingPoint = CGPoint(x: screenWidthCenter, y: 0)
                        let center1 = CGPoint(x: CGFloat(x1), y: CGFloat(y1))
                        path.move(to: startingPoint)
                        path.addLine(to: center1)
                    }
                    .stroke(Color.black, lineWidth: 4)
                    Image("Planet")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 250)
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
                Button(action: {
                    appSettings.viewController = 0

                    let impact = UIImpactFeedbackGenerator(style: UIImpactFeedbackGenerator.FeedbackStyle.medium)
                    impact.impactOccurred()
                }, label: {
                    ZStack {
                        Color(red: 0.53, green: 0.36, blue: 1.0)
                            .frame(width: 250, height: 90)
                            .cornerRadius(10)
                        Text("Start")
                            .fontWeight(.bold)
                            .font(.system(size: 42))
                            .padding()
                            .foregroundColor(Color.white)
                    }
                })
                .padding(.bottom, 20)
            }
            .padding()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(AppSettings())
    }
}
