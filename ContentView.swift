import SwiftUI

struct DoublePendulumView: View {
    @State var angle1: Double = .pi / 1.9
    @State var angle2: Double = .pi / 1.8

    var body: some View {
        let line1: Double = 150
        let line2: Double = 150
        let firstVertexMass: Double = 25
        let secondVertexMass: Double = 25
        let gravity = 0.1
        var angle2Velocity: Double = 0
        var angle1Velocity: Double = 0

        let x1: Double = line1 * sin(angle1) + 420
        let y1: Double = line1 * cos(angle1) + 150
        let x2: Double = x1 + (line2 * sin(angle2))
        let y2: Double = y1 + (line2 * cos(angle2))

        ZStack {
            Path { path in
                let startingPoint = CGPoint(x: 420, y: 150)
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
                .foregroundColor(.blue)
                .position(x: CGFloat(x1), y: CGFloat(y1))
            Circle()
                .frame(width: CGFloat(secondVertexMass), height: CGFloat(secondVertexMass))
                .foregroundColor(.blue)
                .position(x: CGFloat(x2), y: CGFloat(y2))
        }
        .onAppear {
            let timer = Timer.scheduledTimer(withTimeInterval: 0.025, repeats: true) { _ in

                let num1: Double = -gravity * (2 * firstVertexMass * secondVertexMass) * sin(angle1)
                let num2: Double = -secondVertexMass * gravity * sin(angle1 - 2 * angle2)
                let num3: Double = -2 * sin(angle1 - angle2) * secondVertexMass
                let num4: Double = angle2Velocity * angle2Velocity * line2 + angle1Velocity * angle1Velocity * line1 * cos(angle1 - angle2)
                let denominator: Double = line1 * (2 * firstVertexMass + secondVertexMass - secondVertexMass * cos(2 * angle1 - 2 * angle2))
                let angle1Acceleration: Double = (num1 + num2 + num3 * num4) / denominator

                let num5: Double = 2 * sin(angle1 - angle2)
                let num6: Double = (angle1Velocity * angle1Velocity * line1 * (firstVertexMass + secondVertexMass))
                let num7: Double = gravity * (firstVertexMass + secondVertexMass) * cos(angle1)
                let num8: Double = angle2Velocity * angle2Velocity * line2 * secondVertexMass * cos(angle1 - angle2)
                let denominator2: Double = line2 * (2 * firstVertexMass + secondVertexMass - secondVertexMass * cos(2 * angle1 - 2 * angle2))
                let angle2Acceleration: Double = (num5 * (num6 + num7 + num8)) / denominator2

                angle1Velocity += angle1Acceleration
                angle1 += angle1Velocity
                angle2Velocity += angle2Acceleration
                angle2 += angle2Velocity

//                angle1Velocity *= 0.999
//                angle2Velocity *= 0.999
            }
            RunLoop.current.add(timer, forMode: .common)
        }
    }
}
