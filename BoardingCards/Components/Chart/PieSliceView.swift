// Modified Pie Chart from https://betterprogramming.pub/build-pie-charts-in-swiftui-822651fbf3f2

import SwiftUI

struct PieSliceView: View {
    var pieSliceData: PieSliceData

    var midRadians: Double {
        return Double.pi / 2.0 - (pieSliceData.startAngle + pieSliceData.endAngle).radians / 2.0
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if !pieSliceData.isStroked {
                    Path { path in
                        let width: CGFloat = min(geometry.size.width, geometry.size.height)
                        let height = width

                        let center = CGPoint(x: width * 0.5, y: height * 0.5)

                        path.move(to: center)

                        path.addArc(
                            center: center,
                            radius: width * 0.5,
                            startAngle: Angle(degrees: -90.0) + pieSliceData.startAngle,
                            endAngle: Angle(degrees: -90.0) + pieSliceData.endAngle,
                            clockwise: false)
                    }
                    .fill(pieSliceData.color)
                } else {
                    Path { path in
                        let width: CGFloat = min(geometry.size.width, geometry.size.height)
                        let height = width

                        let center = CGPoint(x: width * 0.5, y: height * 0.5)

                        path.move(to: center)

                        path.addArc(
                            center: center,
                            radius: width * 0.5,
                            startAngle: Angle(degrees: -90.0) + pieSliceData.startAngle,
                            endAngle: Angle(degrees: -90.0) + pieSliceData.endAngle,
                            clockwise: false)
                    }
                    .stroke(lineWidth: 5)
                    .fill(Color.black)
                }
            }
        }
        .aspectRatio(1, contentMode: .fit)
    }
}
