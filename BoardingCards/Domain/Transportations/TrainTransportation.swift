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

    func instructions(origin: City, destination: City) -> [AttributedString] {
        [
            try! AttributedString(markdown: String(
                format: "Take train **%@** from **%@** to **%@**. Sit in seat **%@**",
                traits.train,
                origin.name,
                destination.name,
                traits.seat
            ))
        ]
    }

    init(traits: Traits) {
        self.traits = traits
    }
}
