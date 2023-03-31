import SwiftUI


struct CircleLineView: View {
    @State var angle1: Float = Float.pi / 4
    @State var angle2: Float = Float.pi / 8
    
    var body: some View {
        let line1: Float = 150
        let line2: Float = 150
        let firstVertexMass: Float = 30
        let secondVertexMass: Float = 30
        let x1: Float = line1 * sin(angle1) + Float(UIScreen.main.bounds.width) / 2
        let y1: Float = line1 * cos(angle1) + 50
        let x2: Float = x1 + (line2 * sin(angle2))
        let y2: Float = y1 + (line2 * cos(angle2))
        ZStack {
            Path { path in
                let startingPoint = CGPoint(x: UIScreen.main.bounds.width / 2, y: 50)
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
            let timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
                angle1 += 0.1
                    }
                    RunLoop.current.add(timer, forMode: .common)
                }
    }
}
