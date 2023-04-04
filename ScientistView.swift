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

    var body: some View {
        ZStack {
            Color(red: 0.85, green: 0.65, blue: 0.95)
                .ignoresSafeArea()
            VStack {
                Text("\(globalMessages.messages1[tapsCounter])")
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 36))
                    .frame(width: 700, height: 500, alignment: .center)
                Image("Professora")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 500, height: 500)
                HStack {
                    if tapsCounter != 0 {
                        Button(action: {
                            tapsCounter -= 1
                        }, label: {
                            Text("Back")
                                .fontWeight(.bold)
                                .font(.system(size: 24))
                                .padding()
                                .background(Color.purple)
                                .foregroundColor(Color.white)
                                .cornerRadius(10)
                        })
                        .padding(.leading, 40)
                    }
                    Spacer()
                    Button(action: {
                        tapsCounter += 1

                        if tapsCounter == 4 {
                            appSettings.viewController = 1
                        }
                    }, label: {
                        Text("Next")
                            .fontWeight(.bold)
                            .font(.system(size: 24))
                            .padding()
                            .background(Color.purple)
                            .foregroundColor(Color.white)
                            .cornerRadius(10)
                    })
                    .padding(.trailing, 40)
                }
            }
        }
    }
}

struct ScientistView_Previews: PreviewProvider {
    static var previews: some View {
        ScientistView().environmentObject(AppSettings())
    }
}
