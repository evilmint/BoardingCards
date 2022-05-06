//
//  JourneyGenerator.swift
//  BoardingCards
//
//  Created by Aleksander Lorenc on 06/05/2022.
//  Copyright © 2022 Aleksander Lorenc. All rights reserved.
//

import Foundation

struct JourneyGenerator {
    func generate() -> Journey {
        Journey.unplanned(boardingCards: [
            makeBoardingCard(origin: City(name: "Tokyo"), destination: City(name: "Warsaw")),
            makeBoardingCard(origin: City(name: "Warsaw"), destination: City(name: "Prague")),
            makeBoardingCard(origin: City(name: "Prague"), destination: City(name: "Budapest")),
            makeBoardingCard(origin: City(name: "Budapest"), destination: City(name: "Berlin")),
            makeBoardingCard(origin: City(name: "Berlin"), destination: City(name: "Vienna"))
        ])
    }
}

private func makeBoardingCard(
    origin: City,
    destination: City,
    transportationType: TransportationMeans? = nil
) -> BoardingCard {
    var transportation: TransportationMeans = transportationType ?? FlightTransportation(
        traits: FlightTransportation.Traits(
            seat: "45B",
            gate: "A",
            flight: "BER45",
            baggageDropMethod: .automatic
        )
    )

    let boardingCard = BoardingCard(
        origin: origin,
        destination: destination,
        transportation: transportation
    )
    transportation.boardingCard = boardingCard
    return boardingCard
}
