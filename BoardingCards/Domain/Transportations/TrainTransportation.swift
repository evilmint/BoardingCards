import Foundation

final class TrainTransportation: TransportationMeans {
    struct Traits {
        typealias Seat = String
        typealias Train = String

        let seat: Seat
        let train: Train
    }

    private let traits: Traits
    let name = "Train"

    weak var boardingCard: BoardingCard?

    var instructions: [AttributedString] {
        guard let boardingCard = boardingCard else { return [] }
        return [
            try! AttributedString(markdown: String(
            format: "Take train **%@** from **%@** to **%@**. Sit in seat **%@**",
            traits.train,
            boardingCard.origin.name,
            boardingCard.destination.name,
            traits.seat
        ))
        ]
    }

    init(traits: Traits) {
        self.traits = traits
    }
}
