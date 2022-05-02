//
//  LoadingView.swift
//  BoardingCards
//
//  Created by Aleksander Lorenc on 01/05/2022.
//  Copyright © 2022 Aleksander Lorenc. All rights reserved.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        GeometryReader { proxy in
            HStack(alignment: .center) {
                VStack(alignment: .center) {
                    Spacer()
                    VStack {
                        PieChartView(
                            values: [30, 60, 45, 225],
                            colors: [
                                Color.white,
                                Color.gray.opacity(0.3),
                                Color.gray.opacity(0.7),
                                Color.gray,
                            ],
                            backgroundColor: Color.white
                        ).frame(
                            width: proxy.size.width * 0.3,
                            height: proxy.size.width * 0.3,
                            alignment: .center
                        )
                        Text("Sorting...")
                    }
                    Spacer()
                }.frame(maxWidth: .infinity)
            }
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
