//
//  SwiftUIView.swift
//  
//
//  Created by Gabriel Gandur on 10/04/23.
//

import SwiftUI

struct SandBoxView: View {
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
    
    @State var line1: Double = 170
    @State var gravity: Double = 0.1
    
    @State var buttonName: String = "play.circle.fill"
    @State var tapsCounter: Int = 0
    @State var toggleNext: Bool = false
    @State var isPlaying: Bool = false
    
    let teacherImages = ["ProfessoraEnsinando", "ProfessoraFalando", "ProfessoraNormal", "ProfessoraNormal"]
    
    var body: some View {
        let screenWidthCenter = Double(UIScreen.main.bounds.width) / 2
        let startingX: Double = 500
        let firstVertexMass: Double = 25
        let secondVertexMass: Double = 25
                
        let x1: Double = line1 * sin(angle1) + screenWidthCenter
        let y1: Double = line1 * cos(angle1) + startingX
        let x2: Double = x1 + (line1 * sin(angle2))
        let y2: Double = y1 + (line1 * cos(angle2))
        
        let firstVertexMass2: Double = 25
        let secondVertexMass2: Double = 25
        
        let x1b: Double = line1 * sin(angle3) + screenWidthCenter
        let y1b: Double = line1 * cos(angle3) + startingX
        let x2b: Double = x1b + (line1 * sin(angle4))
        let y2b: Double = y1b + (line1 * cos(angle4))
        
        ZStack {
            BackgroundColor()
            VStack {
                ZStack {
                    // First Pendulum
                    Pendulum(color: Color.red,
                             startingX: 500,
                             x1: x1b,
                             y1: y1b,
                             x2: x2b,
                             y2: y2b)
                    
                    // Second Pendulum
                    Pendulum(color: Color.blue,
                             startingX: 500,
                             x1: x1,
                             y1: y1,
                             x2: x2,
                             y2: y2)
                    VStack {
                        HeaderControls(angle1: $angle1,
                                       angle2: $angle2,
                                       angle3: $angle3,
                                       angle4: $angle4,
                                       angle1Velocity: $angle1Velocity,
                                       angle2Velocity: $angle2Velocity,
                                       angle3Velocity: $angle3Velocity,
                                       angle4Velocity: $angle4Velocity,
                                       angle1Acceleration: $angle1Acceleration,
                                       angle2Acceleration: $angle2Acceleration,
                                       angle3Acceleration: $angle3Acceleration,
                                       angle4Acceleration: $angle4Acceleration,
                                       isSimulationStarted: $isSimulationStarted,
                                       toggleNext: $toggleNext,
                                       buttonName: $buttonName,
                                       isPlaying: $isPlaying)
                        
                        if !isPlaying {
                            Text("Blue Pendulum Angles")
                            Slider(value: $angle1, in: 0...6.28)
                                .frame(width: 500)
                            Slider(value: $angle2, in: 0...6.28)
                                .frame(width: 500)
                            Text("Red Pendulum Angles")
                            Slider(value: $angle3, in: 0...6.28)
                                .frame(width: 500)
                            Slider(value: $angle4, in: 0...6.28)
                                .frame(width: 500)
                            Text("Line Length")
                            Slider(value: $line1, in: 100...200)
                                .frame(width: 500)
                            Text("Gravity")
                            Slider(value: $gravity, in: 0.001...0.1)
                                .frame(width: 500)
                        }
                        
                        Spacer()
                        Button(action: {
                            appSettings.viewController = 0
                        }, label: {
                            ZStack {
                                Color(red: 0.53, green: 0.36, blue: 1.0)
                                    .frame(width: 350, height: 90)
                                    .cornerRadius(10)
                                Text("Back to Home")
                                    .fontWeight(.bold)
                                    .font(.system(size: 42))
                                    .padding()
                                    .background(HighlightColor)
                                    .foregroundColor(Color.white)
                            }
                        })
                        .padding(.bottom, 20)
                    }
                    .padding()
                }
                .onAppear {
                    let timer = Timer.scheduledTimer(withTimeInterval: 0.025, repeats: true) { _ in
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
                                                               line2: line1)
                        
                        // Second pendulum angles calculations
                        (angle3Acceleration,
                         angle4Acceleration) = calculateAngles(gravity: gravity,
                                                               firstVertexMass: firstVertexMass2,
                                                               secondVertexMass: secondVertexMass2,
                                                               angle1: angle3,
                                                               angle2: angle4,
                                                               angle1Velocity: angle3Velocity,
                                                               angle2Velocity: angle4Velocity,
                                                               line1: line1,
                                                               line2: line1)
                        
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
        }
    }
}
struct SandBoxView_Previews: PreviewProvider {
    static var previews: some View {
        SandBoxView().environmentObject(AppSettings())
    }
}
