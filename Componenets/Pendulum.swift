//
//  SwiftUIView.swift
//
//
//  Created by Gabriel Gandur on 06/04/23.
//

import Foundation
import SwiftUI

struct Pendulum: View {
    let screenWidthCenter = Double(UIScreen.main.bounds.width) / 2
    let firstVertexMass: Double = 25
    let secondVertexMass: Double = 25
    let color: Color

    let startingX: Double
    let x1, y1, x2, y2: Double

    var body: some View {
        Path { path in
            let startingPoint = CGPoint(x: screenWidthCenter, y: startingX)
            let center1 = CGPoint(x: CGFloat(x1), y: CGFloat(y1))
            let center2 = CGPoint(x: CGFloat(x2), y: CGFloat(y2))
            path.move(to: startingPoint)
            path.addLine(to: center1)
            path.move(to: center1)
            path.addLine(to: center2)
        }
        .stroke(Color.black, lineWidth: 2)
        Circle()
            .frame(width: CGFloat(firstVertexMass), height: CGFloat(firstVertexMass))
            .foregroundColor(color)
            .position(x: CGFloat(x1), y: CGFloat(y1))
        Circle()
            .frame(width: CGFloat(secondVertexMass), height: CGFloat(secondVertexMass))
            .foregroundColor(color)
            .position(x: CGFloat(x2), y: CGFloat(y2))
    }
}
