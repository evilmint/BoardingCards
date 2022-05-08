import ComposableArchitecture

func stateReducer() -> Reducer<AppState, AppAction, AppEnvironment> {
    Reducer { state, action, environment in
        switch action {
        case .result(.sort(let boardingCards)):
            return .concatenate(
                .init(value: .loading(LoadingAction.empty)),
                environment.journeyPlanner.planEffect(using: boardingCards)
                    .map(AppAction.journeyPlanned)
            )

        case .result(.refresh):
            state = resultState(journey: environment.journeyGenerator.generate())
            return .none

        case .loading:
            state = .loading(.init())
            return .none

        case .journeyPlanned(let journey):
            state = resultState(journey: journey)
            return .none
        }
    }
}

private func resultState(journey: Journey) -> AppState {
    .result(ResultState(journey: journey))
}
