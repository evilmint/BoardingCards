import ComposableArchitecture

struct ResultReducer: ReducerProtocol {
    enum Action: Sendable, Equatable {
        case plan(Journey)
        case refresh
        case presentDetails(Bool, BoardingCard?)
        case detailsDismissed
    }

    struct State: Equatable {
        let journey: Journey!
        let detailsVisible: Bool
        let boardingCardDetail: BoardingCard?

        var sortingAllowed: Bool {
            journey.isPlanned
        }
    }

    var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case let .presentDetails(present, boardingCard):
                state = ResultReducer.State(
                    journey: state.journey,
                    detailsVisible: present,
                    boardingCardDetail: boardingCard
                )
                return .none
            case .detailsDismissed:
                state = ResultReducer.State(
                    journey: state.journey,
                    detailsVisible: false,
                    boardingCardDetail: nil
                )
                return .none
            default:
                return .none
            }
        }
    }
}
