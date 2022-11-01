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

    func instructions(origin: City, destination: City) -> [AttributedString] {
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
                        origin.name,
                        traits.flight,
                        destination.name
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
