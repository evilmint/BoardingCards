import Foundation
import SwiftUI
import ComposableArchitecture

struct ResultDetailsView: View {
    let boardingCard: BoardingCard

    var body: some View {
        VStack {
            Card {
                ForEach(boardingCard.transportation.instructions, id: \.self) { instruction in
                    Text("• \(instruction)")
                        .foregroundColor(BoardingCardsColor.textLightBackground)
                        .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12))
                }
            }

            Spacer()
        }
        .edgesIgnoringSafeArea(.all)
        .frame(maxWidth: .infinity)
        .padding()
        .navigationTitle(boardingCard.header)
        .background(BoardingCardsColor.background)
    }
}

struct ResultDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let transportation = BusTransportation(traits: .init(type: .airport))
        let boardingCard = BoardingCard(
            origin: City(name: "Warsaw"),
            destination: City(name: "Tallinn"),
            transportation: transportation
        )
        transportation.boardingCard = boardingCard

        return ElementPreview(ResultDetailsView(boardingCard: boardingCard))
    }
}
