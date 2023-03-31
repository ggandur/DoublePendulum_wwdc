import SwiftUI

struct CircleLineView: View {
    @State var angle1: Float = .pi / 2
    @State var angle2: Float = .pi / 2.1

    var body: some View {
        let line1: Float = 150
        let line2: Float = 150
        let firstVertexMass: Float = 30
        let secondVertexMass: Float = 30
        let gravity: Float = 0.1
        var angle1Velocity: Float = 0
        var angle2Velocity: Float = 0

        let x1: Float = line1 * sin(angle1) + Float(UIScreen.main.bounds.width) / 2
        let y1: Float = line1 * cos(angle1) + 450
        let x2: Float = x1 + (line2 * sin(angle2))
        let y2: Float = y1 + (line2 * cos(angle2))

        ZStack {
            Path { path in
                let startingPoint = CGPoint(x: UIScreen.main.bounds.width / 2, y: 450)
                let center1 = CGPoint(x: CGFloat(x1), y: CGFloat(y1))
                let center2 = CGPoint(x: CGFloat(x2), y: CGFloat(y2))
                path.move(to: startingPoint)
                path.addLine(to: center1)
                path.move(to: center1)
                path.addLine(to: center2)
            }
            .stroke(Color.black, lineWidth: 2)
            Circle()
                .frame(width: CGFloat(firstVertexMass))
                .foregroundColor(.red)
                .position(x: CGFloat(x1), y: CGFloat(y1))
            Circle()
                .frame(width: CGFloat(secondVertexMass))
                .foregroundColor(.blue)
                .position(x: CGFloat(x2), y: CGFloat(y2))
        }
        .onAppear {
            let timer = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { _ in

                var num1 = -gravity * (2 * firstVertexMass * secondVertexMass) * sin(angle1)
                var num2 = -secondVertexMass * gravity * sin(angle1 - 2 * angle2)
                var num3 = -2 * sin(angle1 - angle2) * secondVertexMass
                var num4 = angle2Velocity * angle2Velocity * line2 + angle1Velocity * angle1Velocity * line1 * cos(angle1 - angle2)
                var denominator = line1 * (2 * firstVertexMass + secondVertexMass - secondVertexMass * cos(2 * angle1 - 2 * angle2))
                var angle1Acceleration = (num1 + num2 + num3 * num4) / denominator
                
                var num5 = 2 * sin(angle1 - angle2)
                var num6 = (angle1Velocity * angle1Velocity * line1 * (firstVertexMass + secondVertexMass))
                var num7 = gravity * (firstVertexMass + secondVertexMass) * cos(angle1)
                var num8 = angle2Velocity * angle2Velocity * line2 * secondVertexMass * cos(angle1 - angle2)
                var denominator2 = line2 * (2 * firstVertexMass + secondVertexMass - secondVertexMass * cos(2 * angle1 - 2 * angle2))
                var angle2Acceleration = (num5 * (num6 + num7 + num8)) / denominator2
                
                angle1Velocity += angle1Acceleration
                angle1 += angle1Velocity
                angle2Velocity += angle2Acceleration
                angle2 += angle2Velocity
                
//                angle1Velocity *= 0.98
//                angle2Velocity *= 0.98
            }
            RunLoop.current.add(timer, forMode: .common)
        }
    }
}
