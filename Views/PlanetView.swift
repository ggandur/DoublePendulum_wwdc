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

    let teacherImages = ["ProfessoraLuz", "ProfessoraFeliz", "ProfessoraNormal", "ProfessoraNormal"]

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
                DialogueView(tapsCounter: $tapsCounter,
                             message: globalMessages.messages7[tapsCounter],
                             tapsThreshold: 2,
                             messageTextColor: InfoColor,
                             viewControllerDestination: 0,
                             images: teacherImages)
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
