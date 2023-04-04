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
            Color(red: 0.85, green: 0.65, blue: 0.95)
                .ignoresSafeArea()
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
                Text("\(globalMessages.messages2[tapsCounter])")
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 36))
                    .frame(width: 700, height: 300, alignment: .center)
                Image("Professora")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 500, height: 300)
                HStack {
                    if tapsCounter != 0 {
                        Button(action: {
                            tapsCounter -= 1
                        }, label: {
                            Text("Back")
                                .fontWeight(.bold)
                                .font(.system(size: 24))
                                .padding()
                                .background(Color.purple)
                                .foregroundColor(Color.white)
                                .cornerRadius(10)
                        })
                        .padding(.leading, 40)
                    }
                    Spacer()
                    Button(action: {
                        tapsCounter += 1
                        
                        if tapsCounter == 4 {
                            appSettings.viewController = 2
                        }
                    }, label: {
                        Text("Next")
                            .fontWeight(.bold)
                            .font(.system(size: 24))
                            .padding()
                            .background(Color.purple)
                            .foregroundColor(Color.white)
                            .cornerRadius(10)
                    })
                    .padding(.trailing, 40)
                }
                .padding(.bottom, 30)
            }
        }
    }
}

struct SinglePendulumView_Previews: PreviewProvider {
    static var previews: some View {
        SinglePendulumView().environmentObject(AppSettings())
    }
}
