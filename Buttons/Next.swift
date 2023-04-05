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

    var viewControllerDestination: Int

    var body: some View {
        Button(action: {
            tapsCounter += 1

            if tapsCounter == 4 {
                appSettings.viewController = viewControllerDestination
            }
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
