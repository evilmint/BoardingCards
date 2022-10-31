import ComposableArchitecture

struct ResultReducer: ReducerProtocol {

    var body: some ReducerProtocol<ResultState, ResultAction> {
        Reduce { state, action in
            switch action {
            case .presentDetails(let present, let boardingCard):
                state = ResultState(journey: state.journey, detailsVisible: present, boardingCardDetail: boardingCard)
                return .none
            case .detailsDismissed:
                state = ResultState(journey: state.journey, detailsVisible: false, boardingCardDetail: nil)
                return .none
            default:
                return .none
            }
        }
    }
}
