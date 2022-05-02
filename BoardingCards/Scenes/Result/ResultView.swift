//
//  ResultView.swift
//  BoardingCards
//
//  Created by Aleksander Lorenc on 01/05/2022.
//  Copyright © 2022 Aleksander Lorenc. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct ResultView: View {
    let store: Store<ResultState, ResultAction>

    var body: some View {
        WithViewStore(store) { viewStore in
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    sortTripButton(viewStore: viewStore)

                    Spacer()
                        .frame(maxWidth: .infinity)
                        .frame(height: 16)

                    Text("Unsorted boarding cards")
                        .fontWeight(.bold)

                    boardingCardsList(viewStore: viewStore)

                    Spacer()
                }
                    .frame(maxWidth: .infinity)
                    .padding()
            }
                .frame(maxWidth: .infinity)
                .background(BoardingCardsColor.background)
        }
    }

    private func sortTripButton(viewStore: ViewStore<ResultState, ResultAction>) -> some View {
        HStack(alignment: .center) {
            if viewStore.sortingAllowed {
                Button("Sort trip") {
                    viewStore.send(.sort(viewStore.boardingCards))
                }.buttonStyle(PrimaryButtonStyle())
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }

    private func boardingCardsList(viewStore: ViewStore<ResultState, ResultAction>) -> some View {
        List {
            ForEach(viewStore.boardingCards, id: \.self) { card in
                VStack(alignment: .leading, spacing: 0) {
                    Text("\(card.transportation.name) - \(card.origin.name) › \(card.destination.name)")
                        .padding(EdgeInsets(top: 12, leading: 16, bottom: 0, trailing: 8))

                    Spacer()

                    Divider()
                        .frame(height: 2)
                        .frame(maxWidth: .infinity)
                        .background(BoardingCardsColor.primary)
                }
                .listRowInsets(EdgeInsets())
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .border(BoardingCardsColor.primary, width: 2)
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(
            store: Store(
                initialState: ResultState(boardingCards: [
                    makeBoardingCard(origin: City(name: "Tokyo"), destination: City(name: "Warsaw")),
                    makeBoardingCard(origin: City(name: "Warsaw"), destination: City(name: "Prague")),
                    makeBoardingCard(origin: City(name: "Prague"), destination: City(name: "Budapest")),
                    makeBoardingCard(origin: City(name: "Budapest"), destination: City(name: "Berlin")),
                    makeBoardingCard(origin: City(name: "Berlin"), destination: City(name: "Vienna"))
                ],
                sortingAllowed: true),
                reducer: Reducer { _, _, _ in .none },
                environment: AppEnvironment(mainQueue: .main, journeyPlanner: JourneyPlanner())
            )
        )
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
