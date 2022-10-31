import Foundation

final class FlightTransportation: TransportationMeans {
    struct Traits {
        typealias Seat = String
        typealias Gate = String
        typealias Flight = String

        enum BaggageDropMethod {
            case automatic
            case manual(String)
        }

        let seat: Seat
        let gate: Gate
        let flight: Flight
        let baggageDropMethod: BaggageDropMethod
    }

    private let traits: Traits
    let name = "Flight"

    weak var boardingCard: BoardingCard?

    var instructions: [AttributedString] {
        guard let boardingCard = boardingCard else { return [] }

        let baggageDropFormatted: String

        switch traits.baggageDropMethod {
        case .automatic:
            baggageDropFormatted = String(format: "Baggage will be **automatically transferred** from your last leg.")
        case .manual(let ticketCounter):
            baggageDropFormatted = String(format: "Baggage drop at ticket counter **%@**.", ticketCounter)
        }

        do {
            return [
                try AttributedString(markdown:
                    String(
                        format: "From **%@**, take flight **%@** to **%@**.",
                        boardingCard.origin.name,
                        traits.flight,
                        boardingCard.destination.name
                    )
                ),
                try AttributedString(markdown: String(
                    format: "Gate **%@**, seat **%@**.",
                    traits.gate,
                    traits.seat
                )),
                try AttributedString(markdown: String(
                    format: "%@",
                    baggageDropFormatted
                ))
            ]
        } catch {
            return []
        }
    }

    init(traits: Traits) {
        self.traits = traits
    }
}
