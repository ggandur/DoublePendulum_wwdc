//
//  SwiftUIView.swift
//
//
//  Created by Gabriel Gandur on 05/04/23.
//

import SwiftUI

struct NextButton: View {
    @EnvironmentObject var appSettings: AppSettings
    @Binding var tapsCounter: Int

    let tapsThreshold: Int
    let viewControllerDestination: Int

    var toggleNext: Bool? = true

    var body: some View {
        if let toggleNext = toggleNext {
            if toggleNext {
                Button(action: {
                    tapsCounter += 1

                    if tapsCounter == tapsThreshold {
                        appSettings.viewController = viewControllerDestination
                    }
                    
                    let impact = UIImpactFeedbackGenerator(style: UIImpactFeedbackGenerator.FeedbackStyle.medium)
                      impact.impactOccurred()
                }, label: {
                    Text("Next")
                        .fontWeight(.bold)
                        .font(.system(size: 24))
                        .padding()
                        .background(HighlightColor)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                })
                .padding(.trailing, 40)
                .padding(.bottom, 20)
            }
        }
    }
}
