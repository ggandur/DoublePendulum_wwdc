//
//  SwiftUIView.swift
//
//
//  Created by Gabriel Gandur on 09/04/23.
//

import SwiftUI

struct ResultsView: View {
    @ObservedObject var globalMessages = GlobalMessages.shared
    @EnvironmentObject var appSettings: AppSettings

    @State var tapsCounter: Int = 0

    let teacherImages = ["ProfessoraEnsinando", "ProfessoraLuz", "ProfessoraNormal", "ProfessoraNormal"]

    var body: some View {
        ZStack {
            BackgroundColor()
            VStack {
                DialogueView(tapsCounter: $tapsCounter,
                             message: globalMessages.messages5[tapsCounter],
                             tapsThreshold: 2,
                             messageTextColor: TextColor,
                             viewControllerDestination: 5,
                             images: teacherImages)
            }
            .padding()
        }
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView().environmentObject(AppSettings())
    }
}
