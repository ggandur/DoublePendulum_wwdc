//
//  ScientistView.swift
//  DoublePendulum
//
//  Created by Gabriel Gandur on 02/04/23.
//

import SwiftUI

struct ScientistView: View {
    @State var tapsCounter: Int = 0
    var body: some View {
        ZStack{
            Color(red: 0.85, green: 0.65, blue: 0.95)
                .ignoresSafeArea()
            Text("You tapped \(tapsCounter) times!")
        }
        .onTapGesture {
            tapsCounter += 1
        }
    }
}

struct ScientistView_Previews: PreviewProvider {
    static var previews: some View {
        ScientistView()
    }
}
