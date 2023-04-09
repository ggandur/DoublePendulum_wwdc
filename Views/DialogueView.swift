//
//  SwiftUIView.swift
//
//
//  Created by Gabriel Gandur on 05/04/23.
//

import SwiftUI

struct DialogueView: View {
    @Binding var tapsCounter: Int

    let message: String
    let tapsThreshold: Int
    let messageTextColor: Color
    let viewControllerDestination: Int
    let images: [String]

    var body: some View {
        Text(message)
            .fontWeight(.bold)
            .multilineTextAlignment(.center)
            .font(.system(size: 36))
            .foregroundColor(messageTextColor)
            .frame(width: 700, height: 300, alignment: .center)
        Spacer()
        switch tapsCounter {
        case 0:
            Image("\(images[0])")
                .resizable()
                .scaledToFit()
                .frame(height: 300)
        case 1:
            Image("\(images[1])")
                .resizable()
                .scaledToFit()
                .frame(height: 300)
        case 2:
            Image("\(images[2])")
                .resizable()
                .scaledToFit()
                .frame(height: 300)
        case 3:
            Image("\(images[3])")
                .resizable()
                .scaledToFit()
                .frame(height: 300)
        default:
            Image("ProfessoraNormal")
                .resizable()
                .scaledToFit()
                .frame(height: 300)
        }
        Spacer()
        HStack {
            if tapsCounter != 0 {
                BackButton(tapsCounter: $tapsCounter)
            }
            Spacer()
            NextButton(tapsCounter: $tapsCounter,
                       tapsThreshold: tapsThreshold, viewControllerDestination: viewControllerDestination)
        }
    }
}
