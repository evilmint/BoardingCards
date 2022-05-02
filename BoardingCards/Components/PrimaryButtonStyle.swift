//
//  PrimaryButtonStyle.swift
//  BoardingCards
//
//  Created by Aleksander Lorenc on 01/05/2022.
//  Copyright © 2022 Aleksander Lorenc. All rights reserved.
//

import Foundation
import SwiftUI

struct PrimaryButtonStyle: PrimitiveButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        PrimaryButton(configuration: configuration)
    }

    struct PrimaryButton: View {
        let configuration: PrimaryButtonStyle.Configuration

        var body: some View {
            VStack {
            Text("Sort trip")
                .padding(EdgeInsets(top: 8, leading: 14, bottom: 8, trailing: 14))
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 6))
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(BoardingCardsColor.primary, lineWidth: 2)
                    )
                .onTapGesture {
                    configuration.trigger()
                }
            }
        }
    }
}
