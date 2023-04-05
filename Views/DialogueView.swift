//
//  SwiftUIView.swift
//
//
//  Created by Gabriel Gandur on 05/04/23.
//

import SwiftUI

struct DialogueView: View {
    @Binding var tapsCounter: Int

    var message: String
    var messageTextColor: Color
    var viewControllerDestination: Int

    var body: some View {
        Text(message)
            .fontWeight(.bold)
            .multilineTextAlignment(.center)
            .font(.system(size: 36))
            .foregroundColor(messageTextColor)
            .frame(width: 700, height: 300, alignment: .center)
        Spacer()
        Image("Professora")
            .resizable()
            .scaledToFit()
            .frame(height: 300)
        Spacer()
        HStack {
            if tapsCounter != 0 {
                BackButton(tapsCounter: $tapsCounter)
            }
            Spacer()
            NextButton(tapsCounter: $tapsCounter,
                       viewControllerDestination: viewControllerDestination)
        }
    }
}
