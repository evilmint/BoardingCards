//
//  PieChartView.swift
//  BoardingCards
//
//  Created by Aleksander Lorenc on 01/05/2022.
//  Copyright © 2022 Aleksander Lorenc. All rights reserved.
//

// Modified Pie Chart from https://betterprogramming.pub/build-pie-charts-in-swiftui-822651fbf3f2

import SwiftUI

struct PieChartView: View {
    public let values: [Double]
    public var colors: [Color]

    public var backgroundColor: Color

    var slices: [PieSliceData] {
        let sum = values.reduce(0, +)
        var endDeg: Double = 0
        var tempSlices: [PieSliceData] = []

        for (i, value) in values.enumerated() {
            let degrees: Double = value * 360 / sum
            tempSlices.append(PieSliceData(startAngle: Angle(degrees: endDeg), endAngle: Angle(degrees: endDeg + degrees),  color: self.colors[i], isStroked: false))
            endDeg += degrees
        }
        return tempSlices
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack{
                ForEach(0 ..< self.values.count, id: \.self) { i in
                    PieSliceView(pieSliceData: self.slices[i])
                }
                .frame(width: geometry.size.width, height: geometry.size.width)

                ForEach(0 ..< self.values.count, id: \.self) { i in
                    PieSliceView(pieSliceData:  PieSliceData(startAngle: self.slices[i].startAngle, endAngle: self.slices[i].endAngle, color: self.slices[i].color, isStroked: true))
                }
                .frame(width: geometry.size.width, height: geometry.size.width)
            }
            .background(self.backgroundColor)
            .foregroundColor(Color.white)
        }
    }
}

struct PieChartView_Previews: PreviewProvider {
    static var previews: some View {
        PieChartView(values: [1300, 500, 300], colors: [Color.blue, Color.green, Color.orange], backgroundColor: Color.white)
    }
}
