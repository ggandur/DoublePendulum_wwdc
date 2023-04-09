//
//  SwiftUIView.swift
//
//
//  Created by Gabriel Gandur on 09/04/23.
//

import SwiftUI

struct VotingView: View {
    @ObservedObject var globalMessages = GlobalMessages.shared
    @EnvironmentObject var appSettings: AppSettings

    @State var tapsCounter: Int = 0

    let teacherImages = ["ProfessoraFalando", "ProfessoraEnsinando", "ProfessoraTriste", "ProfessoraNormal"]

    var body: some View {
        ZStack {
            BackgroundColor()
            VStack {
                Image("HandVoting")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 425)
                DialogueView(tapsCounter: $tapsCounter,
                             message: globalMessages.messages6[tapsCounter],
                             tapsThreshold: 3,
                             messageTextColor: TextColor,
                             viewControllerDestination: 6,
                             images: teacherImages)
            }
            .padding()
        }
    }
}

struct VotingView_Previews: PreviewProvider {
    static var previews: some View {
        VotingView().environmentObject(AppSettings())
    }
}
