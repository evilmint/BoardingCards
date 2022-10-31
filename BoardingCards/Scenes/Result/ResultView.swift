import SwiftUI
import ComposableArchitecture

struct ResultView: View {
    let store: Store<ResultState, ResultAction>

    var body: some View {
        WithViewStore(store) { viewStore in
            VStack(alignment: .leading) {
                ZStack {
                    if !viewStore.journey.isPlanned {
                        sortTripButton(viewStore: viewStore)
                    } else {
                        #if targetEnvironment(macCatalyst)
                        refreshTripButton(viewStore: viewStore)
                        #endif
                    }
                }.frame(maxWidth: .infinity, alignment: .center)

                Spacer()
                    .frame(maxWidth: .infinity)
                    .frame(height: 16)

                Text(sortButtonText(journey: viewStore.journey))
                    .fontWeight(.bold)
                    .foregroundColor(BoardingCardsColor.text)

                boardingCardsList(viewStore: viewStore)
            }
            .frame(maxWidth: .infinity)
            .padding()
        }.background(BoardingCardsColor.background)
    }

    private func sortButtonText(journey: Journey) -> String {
        journey.isPlanned ?
        "Sorted boarding cards" :
        "Unsorted boarding cards"
    }

    private func sortTripButton(
        viewStore: ViewStore<ResultState, ResultAction>
    ) -> some View {
        Button("Sort trip") {
            viewStore.send(.plan(viewStore.journey))
        }.buttonStyle(PrimaryButtonStyle())
    }

    private func refreshTripButton(
        viewStore: ViewStore<ResultState, ResultAction>
    ) -> some View {
        Button("Refresh") {
            viewStore.send(.refresh)
        }.buttonStyle(PrimaryButtonStyle())
    }

    private func boardingCardsList(
        viewStore: ViewStore<ResultState, ResultAction>
    ) -> some View {
        ZStack {
            ItemList(viewStore.journey.boardingCards) { card in
                Text(card.header)
                    .foregroundColor(BoardingCardsColor.textLightBackground)
            }.onItemTap { card in
                if viewStore.journey.isPlanned {
                    viewStore.send(.presentDetails(true, card))
                }
            }
            .if(viewStore.journey.isPlanned) { view in
                view.refreshable(store: viewStore, action: .refresh)
            }

            NavigationLink(
                destination: IfLetStore(
                    store.scope(
                        state: \.boardingCardDetail,
                        action: { _ in ResultAction.presentDetails(false, nil) }
                    ),
                    then: { (store: Store<BoardingCard, Error>) in
                        ResultDetailsView(boardingCard: ViewStore(store).state)
                            .background(BoardingCardsColor.background)
                    }
                ),
                isActive: viewStore.binding(
                    get: \.detailsVisible,
                    send: { $0 ? .presentDetails(true, nil) : .detailsDismissed }
                )
            ) {
                EmptyView()
            }
            .opacity(0)
        }
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ElementPreview(
            ResultView(
                store: Store(
                    initialState: ResultState(journey: JourneyGenerator().generate(), detailsVisible: false, boardingCardDetail: nil),
                    reducer: ResultReducer()
                )
            )
        )
    }
}
