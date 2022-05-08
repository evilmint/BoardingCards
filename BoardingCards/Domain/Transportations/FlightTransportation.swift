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

    var instructions: String? {
        guard let boardingCard = boardingCard else {
            return nil
        }

        let baggageDropFormatted: String

        switch traits.baggageDropMethod {
        case .automatic:
            baggageDropFormatted = String(format: "Baggage will we automatically transferred from your last leg.")
        case .manual(let ticketCounter):
            baggageDropFormatted = String(format: "Baggage drop at ticket counter %@.", ticketCounter)
        }

        return String(
            format: "From %@, take flight %@ to %@. Gate %@, seat %@. %@",
            boardingCard.origin.name,
            traits.flight,
            boardingCard.destination.name,
            traits.gate,
            traits.seat,
            baggageDropFormatted
        )
    }

    init(traits: Traits) {
        self.traits = traits
    }
}
