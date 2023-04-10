//
//  SwiftUIView.swift
//
//
//  Created by Gabriel Gandur on 09/04/23.
//

import SwiftUI

struct PlanetView: View {
    @ObservedObject var globalMessages = GlobalMessages.shared
    @EnvironmentObject var appSettings: AppSettings

    @State var tapsCounter: Int = 0
    @State private var isRotating = 0.0

    let teacherImages = ["ProfessoraLuz", "ProfessoraFelizRosa", "ProfessoraEnsinando", "ProfessoraEnsinando"]

    var body: some View {
        ZStack {
            Image("SpaceBackground")
                .scaledToFill()
            VStack {
                Image("Planet")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 425)
                    .rotationEffect(.degrees(isRotating))
                    .onAppear {
                        withAnimation(.linear(duration: 1)
                            .speed(0.1).repeatForever(autoreverses: false))
                        {
                            isRotating = 360.0
                        }
                    }
                if tapsCounter <= 2 {
                    DialogueView(tapsCounter: $tapsCounter,
                                 message: globalMessages.messages7[tapsCounter],
                                 tapsThreshold: 4,
                                 messageTextColor: InfoColor,
                                 viewControllerDestination: 7,
                                 images: teacherImages)
                } else {
                    Spacer()
                    Image("ProfessoraConvencida")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 400)
                    Spacer()
                    ZStack {
                        Button(action: {
                            appSettings.viewController = 8
                        }, label: {
                            ZStack {
                                Color(red: 0.53, green: 0.36, blue: 1.0)
                                    .frame(width: 250, height: 80)
                                    .cornerRadius(10)
                                Text("Sandbox")
                                    .fontWeight(.bold)
                                    .font(.system(size: 42))
                                    .padding()
                                    .foregroundColor(Color.white)
                            }
                        })
                        HStack {
                            Button(action: {
                                appSettings.viewController = 7
                            }, label: {
                                ZStack {
                                    Color(red: 0.53, green: 0.36, blue: 1.0)
                                        .frame(width: 100, height: 100)
                                        .cornerRadius(10)
                                    Image(systemName: "house")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 50)
                                        .foregroundColor(.white)
                                }
                            })
                            .padding(.leading, 20)
                            Spacer()
                        }
                    }
                    .padding(.bottom, 20)
                }
            }
            .padding()
        }
    }
}

struct PlanetView_Previews: PreviewProvider {
    static var previews: some View {
        PlanetView().environmentObject(AppSettings())
    }
}
