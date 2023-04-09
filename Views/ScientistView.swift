//
//  ScientistView.swift
//  DoublePendulum
//
//  Created by Gabriel Gandur on 02/04/23.
//

import Foundation
import SwiftUI

struct ScientistView: View {
    @ObservedObject var globalMessages = GlobalMessages.shared
    @EnvironmentObject var appSettings: AppSettings

    @State var tapsCounter: Int = 0

    let teacherImages = ["ProfessoraFeliz", "ProfessoraFalando", "ProfessoraLuz", "ProfessoraConvencida"]

    var body: some View {
        ZStack {
            BackgroundColor()
            VStack {
                DialogueView(tapsCounter: $tapsCounter,
                             message: globalMessages.messages1[tapsCounter],
                             tapsThreshold: 4,
                             messageTextColor: TextColor,
                             viewControllerDestination: 1,
                             images: teacherImages)
            }
        }
    }
}

struct ScientistView_Previews: PreviewProvider {
    static var previews: some View {
        ScientistView().environmentObject(AppSettings())
    }
}
