//
//  File.swift
//
//
//  Created by Gabriel Gandur on 06/04/23.
//

import Foundation

func calculateAngles(gravity: Double, firstVertexMass: Double, secondVertexMass: Double, angle1: Double, angle2: Double, angle1Velocity: Double, angle2Velocity: Double, line1: Double, line2: Double) -> (Double, Double) {
    var num1: Double = -gravity * (2 * firstVertexMass * secondVertexMass) * sin(angle1)
    var num2: Double = -secondVertexMass * gravity * sin(angle1 - 2 * angle2)
    var num3: Double = -2 * sin(angle1 - angle2) * secondVertexMass
    var num4: Double = angle2Velocity * angle2Velocity * line2 + angle1Velocity * angle1Velocity * line1 * cos(angle1 - angle2)
    var denominator: Double = line1 * (2 * firstVertexMass + secondVertexMass - secondVertexMass * cos(2 * angle1 - 2 * angle2))
    let angle1Acceleration = (num1 + num2 + num3 * num4) / denominator

    num1 = 2 * sin(angle1 - angle2)
    num2 = (angle1Velocity * angle1Velocity * line1 * (firstVertexMass + secondVertexMass))
    num3 = gravity * (firstVertexMass + secondVertexMass) * cos(angle1)
    num4 = angle2Velocity * angle2Velocity * line2 * secondVertexMass * cos(angle1 - angle2)
    denominator = line2 * (2 * firstVertexMass + secondVertexMass - secondVertexMass * cos(2 * angle1 - 2 * angle2))
    let angle2Acceleration = (num1 * (num2 + num3 + num4)) / denominator

    return (angle1Acceleration, angle2Acceleration)
}
