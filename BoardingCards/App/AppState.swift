//
//  AppState.swift
//  BoardingCards
//
//  Created by Aleksander Lorenc on 01/05/2022.
//  Copyright © 2022 Aleksander Lorenc. All rights reserved.
//

import Foundation

struct ResultState: Equatable {
    let boardingCards: [BoardingCard]
    let sortingAllowed: Bool
}

struct LoadingState: Equatable {}

enum AppState: Equatable {
    case result(ResultState)
    case loading(LoadingState)

    public init() {
        self = .result(.init(
            boardingCards: [
                makeBoardingCard(origin: City(name: "Tokyo"), destination: City(name: "Warsaw")),
                makeBoardingCard(origin: City(name: "Warsaw"), destination: City(name: "Prague")),
                makeBoardingCard(origin: City(name: "Prague"), destination: City(name: "Budapest")),
                makeBoardingCard(origin: City(name: "Budapest"), destination: City(name: "Berlin")),
                makeBoardingCard(origin: City(name: "Berlin"), destination: City(name: "Vienna"))
            ].shuffled(),
            sortingAllowed: true
        ))
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
