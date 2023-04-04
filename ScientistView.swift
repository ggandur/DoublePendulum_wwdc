//
//  ScientistView.swift
//  DoublePendulum
//
//  Created by Gabriel Gandur on 02/04/23.
//

import Foundation
import SwiftUI

struct ScientistView: View {
    @EnvironmentObject var appSettings: AppSettings
    @State var tapsCounter: Int = 0

    var body: some View {
        ZStack {
            Color(red: 0.85, green: 0.65, blue: 0.95)
                .ignoresSafeArea()
            VStack {
                Text("You tapped \(tapsCounter) times!")
                    .fontWeight(.bold)
                    .font(.system(size: 36))
                    .padding(EdgeInsets(top: 50, leading: 0, bottom: 0, trailing: 0))
                Spacer()
                HStack {
                    Image("Professora")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 500, height: 500)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 25, trailing: 0))
                    Spacer()
                }
            }
        }
        .onTapGesture {
            tapsCounter += 1

            if tapsCounter == 5 {
                appSettings.viewController = 1
            }
        }
    }
}

struct ScientistView_Previews: PreviewProvider {
    static var previews: some View {
        ScientistView().environmentObject(AppSettings())
    }
}
