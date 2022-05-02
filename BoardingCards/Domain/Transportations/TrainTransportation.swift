//
//  TrainTransportation.swift
//  BoardingCards
//
//  Created by Aleksander Lorenc on 01/05/2022.
//  Copyright © 2022 Aleksander Lorenc. All rights reserved.
//

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

    var instructions: String? {
        guard let boardingCard = boardingCard else { return nil }
        return String(
            format: "Take train %@ from %@ to %@. Sit in seat %@",
            traits.train,
            boardingCard.origin.name,
            boardingCard.destination.name,
            traits.seat
        )
    }

    init(traits: Traits) {
        self.traits = traits
    }
}
