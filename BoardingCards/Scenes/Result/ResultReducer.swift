import ComposableArchitecture

func resultReducer() -> Reducer<ResultState, ResultAction, AppEnvironment> {
    Reducer { state, action, environment in
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
