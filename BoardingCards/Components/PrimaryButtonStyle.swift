import Foundation
import SwiftUI

struct PrimaryButtonStyle: PrimitiveButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack {
            configuration.label
                .padding(EdgeInsets(top: 8, leading: 14, bottom: 8, trailing: 14))
                .background(Color.white)
                .foregroundColor(BoardingCardsColor.textLightBackground)
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
