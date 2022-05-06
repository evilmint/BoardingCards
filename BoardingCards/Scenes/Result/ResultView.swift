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
            VStack(alignment: .leading) {
                sortTripButton(viewStore: viewStore)
                    .frame(maxWidth: .infinity, alignment: .center)

                Spacer()
                    .frame(maxWidth: .infinity)
                    .frame(height: 16)

                Text(viewStore.journey.isPlanned ?
                     "Sorted boarding cards" :
                     "Unsorted boarding cards"
                )
                    .fontWeight(.bold)

                boardingCardsList(viewStore: viewStore)
            }
                .frame(maxWidth: .infinity)
                .padding()
        }.background(BoardingCardsColor.background)
    }

    private func sortTripButton(
        viewStore: ViewStore<ResultState, ResultAction>
    ) -> some View {
        Group {
            if !viewStore.journey.isPlanned {
                Button("Sort trip") {
                    viewStore.send(.sort(viewStore.journey.boardingCards))
                }.buttonStyle(PrimaryButtonStyle())
            }
        }
    }

    private func boardingCardsList(viewStore: ViewStore<ResultState, ResultAction>) -> some View {
        List {
            ForEach(viewStore.journey.boardingCards, id: \.self) { card in
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
        .if(viewStore.journey.isPlanned) { view in
            view.refreshable {
                viewStore.send(.refresh)
            }
        }
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(
            store: Store(
                initialState: ResultState(journey: JourneyGenerator().generate()),
                reducer: Reducer { _, _, _ in .none },
                environment: AppEnvironment(
                    mainQueue: .main,
                    journeyPlanner: JourneyPlanner(),
                    journeyGenerator: JourneyGenerator()
                )
            )
        )
    }
}
