//
//  SwiftUIView.swift
//
//
//  Created by Gabriel Gandur on 06/04/23.
//

import Foundation
import SwiftUI

struct HeaderPlaceholder: View {
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "arrow.clockwise.circle.fill")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .foregroundColor(Color.purple.opacity(0.8))
                Spacer()
                Image(systemName: "play.circle.fill")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .foregroundColor(Color.purple.opacity(0.8))
            }
            .frame(width: 650)
            .padding(.top, 40)
            Spacer()
        }
    }
}
