//
//  SwiftUIView.swift
//
//
//  Created by Gabriel Gandur on 05/04/23.
//

import SwiftUI

struct BackButton: View {
    @Binding var tapsCounter: Int

    var body: some View {
        Button(action: {
            if tapsCounter > 0 {
                tapsCounter -= 1
            }
        }, label: {
            Text("Back")
                .fontWeight(.bold)
                .font(.system(size: 24))
                .padding()
                .background(HighlightColor)
                .foregroundColor(Color.white)
                .cornerRadius(10)
        })
        .padding(.leading, 40)
        .padding(.bottom, 20)
    }
}
