//
//  BusTransportation.swift
//  BoardingCards
//
//  Created by Aleksander Lorenc on 01/05/2022.
//  Copyright © 2022 Aleksander Lorenc. All rights reserved.
//

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

    var instructions: String? {
        guard let boardingCard = boardingCard else { return nil }

        switch traits.type {
        case .airport:
            return String(
                format: "Take the airport bus from %@ to %@. No seat assignment.",
                boardingCard.origin.name,
                boardingCard.destination.name
            )
        case .regular(let seat):
            return String(
                format: "Take the airport bus from %@ to %@. Seat %@.",
                boardingCard.origin.name,
                boardingCard.destination.name,
                seat
            )
        }
    }

    init(traits: Traits) {
        self.traits = traits
    }
}
