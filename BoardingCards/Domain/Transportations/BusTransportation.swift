import Foundation

final class BusTransportation: TransportationMeans {
    struct Traits {
        enum BusType {
            typealias Seat = String

            case airport
            case regular(Seat)
        }

        let type: BusType
    }

    private let traits: Traits
    let name = "Bus"

    weak var boardingCard: BoardingCard?

    var instructions: [AttributedString] {
        guard let boardingCard = boardingCard else { return [] }

        switch traits.type {
        case .airport:
            do {
                return [try AttributedString(markdown: String(
                    format: "Take the airport bus from **%@** to **%@**.",
                    boardingCard.origin.name,
                    boardingCard.destination.name
                )),
                                 try AttributedString(markdown:  String(
                    format: "No seat assignment."
                ))]
            } catch {
                return [AttributedString("wow")]
            }
        case .regular(let seat):
            return [
                try! AttributedString(markdown: String(
                    format: "Take the airport bus from **%@** to **%@**..",
                    boardingCard.origin.name,
                    boardingCard.destination.name
                )),
                try! AttributedString(markdown: String(format: "Seat **%@**.", seat))
            ]
        }
    }

    init(traits: Traits) {
        self.traits = traits
    }
}
