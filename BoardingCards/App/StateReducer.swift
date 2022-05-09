import ComposableArchitecture

func stateReducer() -> Reducer<AppState, AppAction, AppEnvironment> {
    Reducer { state, action, environment in
        switch action {
        case .result(.plan(let journey)):
            return .concatenate(
                Effect(value: .loading(.empty)),
                environment.journeyPlanner.planEffect(using: journey.boardingCards)
                    .map(AppAction.journeyPlanned)
            )

        case .result(.refresh):
            state = .result(journey: environment.journeyGenerator.generate())
            return .none

        case .loading:
            state = .loading(.init())
            return .none

        case .journeyPlanned(let journey):
            state = .result(journey: journey)
            return .none

        case .result:
            return .none
        }
    }
}
